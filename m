Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284337AbRLGTAo>; Fri, 7 Dec 2001 14:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbRLGTAf>; Fri, 7 Dec 2001 14:00:35 -0500
Received: from freesurfmta04.sunrise.ch ([194.230.0.33]:7145 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id <S284337AbRLGTAY>; Fri, 7 Dec 2001 14:00:24 -0500
Message-ID: <3C0B853000063099@freesurfmail.sunrise.ch> (added by
	    postmaster@freesurf.ch)
Content-Type: text/plain; charset=US-ASCII
From: Nicolas Vollmar <nv@bluewin.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.1pre6 compile error setup.c
Date: Fri, 7 Dec 2001 20:00:24 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had tried to compile 2.5.1-pre6 and have got this error:


setup.c: In function `setup_arch':
setup.c:806: `rd_image_start' undeclared (first use in this function)
setup.c:806: (Each undeclared identifier is reported only once
setup.c:806: for each function it appears in.)
setup.c:807: `rd_prompt' undeclared (first use in this function)
setup.c:808: `rd_doload' undeclared (first use in this function)
make[1]: *** [setup.o] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2


Nicolas
