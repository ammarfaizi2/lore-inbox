Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129686AbRB0SEG>; Tue, 27 Feb 2001 13:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRB0SDy>; Tue, 27 Feb 2001 13:03:54 -0500
Received: from emorific.net ([216.122.23.200]:40713 "EHLO emorific.com")
	by vger.kernel.org with ESMTP id <S129686AbRB0SDt>;
	Tue, 27 Feb 2001 13:03:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Bug Report in pc_keyb
Message-Id: <E14XoU0-0003ZY-00@emorific.com>
From: "Russell C. Hay" <shakes@emorific.com>
Date: Tue, 27 Feb 2001 18:04:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not really sure who to send this too.  Unfortunately, I don't really have
much information on this bug, and I will provide more when I'm around the box
in question.  I have linux 2.2.16 running fine on the box.  I am currently
trying to upgrade to linux 2.4.2.  However, after compiling 2.4.2 and 
installing in lilo and rebooting, I get the following error scrolling on
my screen

"pc_keyb: controller jammed (0xFF)"

The box in question is a pentII with a supermicro motherboard.  I don't know
the exact model number of the motherboard.  I think it is the p6sls board.
I did some research on the error message, and apparently people have been
getting this error on Alpha based systems too.  Does anyone know how to
resolve this issue or if it is a known bug that is planning to be fixed
or something along those lines?
