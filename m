Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266523AbRGTOAV>; Fri, 20 Jul 2001 10:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266723AbRGTOAL>; Fri, 20 Jul 2001 10:00:11 -0400
Received: from epona.physics.nuigalway.ie ([140.203.1.3]:44808 "EHLO
	epona.physics.nuigalway.ie") by vger.kernel.org with ESMTP
	id <S266523AbRGTN75>; Fri, 20 Jul 2001 09:59:57 -0400
Message-ID: <01C1112C.B06C5F10.oryan@physics.nuigalway.ie>
From: Oliver Ryan <oryan@physics.nuigalway.ie>
Reply-To: "oryan@physics.nuigalway.ie" <oryan@physics.nuigalway.ie>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: newbie creating scatter/gather list
Date: Fri, 20 Jul 2001 15:00:16 +0100
Organization: nui, galway
X-Mailer: Microsoft Internet E-mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi all,

I want to create a scatter/gather list for dma from a pci device. I've read 
DMA-mapping.txt and a host of other stuff, but most of it assumes I know 
the 'basics' already, which I don't and can't find.  Kernelnewbies sent me 
here.

I want to use the pci_map_sg() function detailed in DMA-mapping .txt, but 
have to pass an already created scatter list to it.  Can anyone tell me how 
to do it, or where to find details on it (an example program?).

Thanks, the help is needed and appreciated.

Oliver.


Dept. of Physics,
National University of Ireland, Galway,
Galway,
Ireland.

Tel: +353 (0)91 524411 ext. 2716
Fax: +353 (0)91 750584
