Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTJRXMl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 19:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbTJRXMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 19:12:41 -0400
Received: from 12-233-44-179.client.attbi.com ([12.233.44.179]:21665 "EHLO
	terminator.outersquare.org") by vger.kernel.org with ESMTP
	id S261930AbTJRXMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 19:12:39 -0400
From: Jeremy Huddleston <jeremyhu@uclink4.berkeley.edu>
To: andre@linux-ide.org
Subject: Promise PDC20269 - PIO Only?
Date: Sat, 18 Oct 2003 16:16:26 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310181616.31093.jeremyhu@uclink4.berkeley.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I've been using two Promise PDC20269 cards for almost a year now in my system.  
The cards are U133, but when the kernel boots up, I see the message that all 
the drives are operating in pio mode.  All the drives are U133 drives, and 
they are shown as operating in DMA mode when I put them on another 
controller.

I've noticed this deficiency with vanilla linux-2.4.19 through linux-2.4.21, 
linux-2.4.22-ac4 as well as 2.6.0-test6-mm4...

Is there a patch to the 2.4 kernels availible to enable this support?  Is this 
problem being addressed?  Is there any way I can help out?

Thanks,
Jeremy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/kcnOgKpk8srJOlIRAmvfAJ9lI/Dw5f6vNqHoAWdeSKXpsO8DdwCgmZ5y
jlD7cw5xmmUOUA72y0PdCI4=
=tMij
-----END PGP SIGNATURE-----
