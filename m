Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135361AbRAUOtS>; Sun, 21 Jan 2001 09:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135719AbRAUOtI>; Sun, 21 Jan 2001 09:49:08 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:20228 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S135361AbRAUOsu>;
	Sun, 21 Jan 2001 09:48:50 -0500
Date: Sun, 21 Jan 2001 15:48:44 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101211448.PAA07015@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: display problem with matroxfb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've a matrox mystique with 8Mb RAM.
I've a problem when I use matroxfb instead vesafb.
If I enable CONFIG_FB_VESA, I get the nice logo and all is right for me.
If I enable CONFIG_FB_MATROX, the beginning of each line is in the middle
of the screen and the cursor position does not match the prompt position.
Nevetheless, the screen is 'readable' (no garbage). I've read the files
in ../Documentation/fb and the Framebuffer-HOWTO.

This appends with both 2.2.xx and 2.4.x kernels.

Do I missed something ?

----
Regards
		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
