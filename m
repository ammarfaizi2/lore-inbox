Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271195AbRHOOH3>; Wed, 15 Aug 2001 10:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271197AbRHOOHK>; Wed, 15 Aug 2001 10:07:10 -0400
Received: from [213.52.152.2] ([213.52.152.2]:58628 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S271195AbRHOOGt>; Wed, 15 Aug 2001 10:06:49 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.8 USB oddity
Message-ID: <997884422.3b7a820675961@extranet.jtrix.com>
Date: Wed, 15 Aug 2001 15:07:02 +0100 (BST)
From: "Martin A. Brooks" <martin@jtrix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
X-Originating-IP: 10.119.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

When using USB under 2.4.8 (OHCI) the driver seem to sporadically re-initialise
itself. The hardware seems to re-detect just fine but this has the nasty side
effect of halting any apps grabbing data from, for example, a hooked up USB
webcam.

Has anyone else had similar experiences? 

(I'm not subscribed, please CC me on any reply.)

Regards  

Martin A. Brooks,  Systems Administrator
------------------------------------------------
Jtrix Ltd		t: +44 207 395 4990
57-59 Neal Street	f: +44 207 395 4991
Covent Garden		e: martin@jtrix.org
London WC2H 9PJ		w: http://www.jtrix.org
