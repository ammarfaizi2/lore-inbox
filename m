Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153852AbQCYPXo>; Sat, 25 Mar 2000 10:23:44 -0500
Received: by vger.rutgers.edu id <S153848AbQCYPXe>; Sat, 25 Mar 2000 10:23:34 -0500
Received: from draal.apex.net.au ([203.37.38.10]:19063 "EHLO draal.apex.net.au") by vger.rutgers.edu with ESMTP id <S153682AbQCYPXT>; Sat, 25 Mar 2000 10:23:19 -0500
Message-ID: <38DCDB0C.1E52E915@cupid.suninternet.com>
Date: Sun, 26 Mar 2000 02:28:12 +1100
From: Martijn van Oosterhout <kleptog@cupid.suninternet.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.14 i586)
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.rutgers.edu>
Subject: [RFC] Packet-Shaping-HOWTO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hello people,

Recently I've had occasion to try to make the QoS and queueing
code from the 2.2 kernel to work for me, but found the 
documentation to be a bit technical and not really aimed for 
users. So, I've summed up my experience with the packet
shaping and stuffed it all into a HOWTO.

However some of it is still guess work since there are some
concepts going on here that I still don't get. No matter,
I would just like people to read over it to see if I got
it right.

Note that this is specifically 2.2, I don't know if 
2.[34] is the same.

http://cupid.suninternet.com/~kleptog/Packet-Shaping-HOWTO.html

Please CC any replies.
-- 
Martijn van Oosterhout <kleptog@cupid.suninternet.com>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
