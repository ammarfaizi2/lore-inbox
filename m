Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288891AbSAIRSV>; Wed, 9 Jan 2002 12:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288246AbSAIRQo>; Wed, 9 Jan 2002 12:16:44 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:17679 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S288787AbSAIRQU>;
	Wed, 9 Jan 2002 12:16:20 -0500
Date: Wed, 09 Jan 2002 18:16:17 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: higher speed on VIA serial ports ?
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3C3C7AE1.4E5D84B1@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some VIA south bridges , including the 82C686B model that I have,
support higher speeds on the serial ports, like 230400, 460800 and
maybe 921600 bps.

Has anyone any docs on how to program the chip for this speeds ?

I only have the VIA 686 register layout. There is a certain "High speed"
bit mentioned. If I set it , and use the system normally to get 115200 bps,
then I get 230400 bps like speeds ( measured FTP transfer rate over null
modem PPP connection between two PCs ).

Anyone know how to get higher speeds ?


-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
