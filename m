Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290688AbSARNTI>; Fri, 18 Jan 2002 08:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290689AbSARNS6>; Fri, 18 Jan 2002 08:18:58 -0500
Received: from web14604.mail.yahoo.com ([216.136.224.84]:24332 "HELO
	web14604.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S290688AbSARNSz>; Fri, 18 Jan 2002 08:18:55 -0500
Message-ID: <20020118131854.44722.qmail@web14604.mail.yahoo.com>
Date: Fri, 18 Jan 2002 05:18:54 -0800 (PST)
From: Ram Shankar <kramsn@yahoo.com>
Subject: LINUX IP Stack
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are interested in moving the IP stack into the
application area. i.e. It should link with our
application and use the devices (like /dev/eth0) for
the layer 2 interface.

Regarding this we have following questions

1. How feasible it will be to move the IP stack from
the kernel to the application level. Note we would
leave one copy of the IP stack in the kernel. But for
the interfaces we are interested in we want the IP
stack to be at the application layer.

If this is feasible, what would be procedure to be
followed?

2. Is there any documentation available for the linux
IP stack and all its interfaces (highest level calls
provided, interfaces to layer2 devices, interfaces to
other kernel services etc.)?

3. Is there any other free implementation of IP stack,
which would be better suited for this purpose?

Thanks,

Ram

__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
