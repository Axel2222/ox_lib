import { Box, Tooltip } from '@chakra-ui/react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';

const InfoTooltip: React.FC<{ description: string }> = ({ description }) => {
  return (
    <Tooltip bg="purple.200" label={description} placement="top" hasArrow arrowSize={4} maxW={220}>
      <Box
        borderRadius="full"
        bg="purple.400"
        p={0.5}
        w={18}
        h={18}
        display="flex"
        alignItems="center"
        justifyContent="center"
      >
        <FontAwesomeIcon icon="question" fixedWidth fontSize={10} />
      </Box>
    </Tooltip>
  );
};

export default InfoTooltip;
