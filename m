Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTE1Ozk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbTE1Ozk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:55:40 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:54750 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264590AbTE1Ozj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:55:39 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Pawel Golaszewski <blues@ds.pg.gda.pl>
Date: Wed, 28 May 2003 17:08:30 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-2
Content-transfer-encoding: 8BIT
Subject: Re: Linux 2.5.70
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <2CE21B51D37@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 May 03 at 16:59, Pawe³ Go³aszewski wrote:
> Finally - I've started to worry if this kernel will be ever released :)
> 
> When building framebuffer driver for my new Matrox G400 I get this error:
> 
> scripts/fixdep drivers/video/logo/.logo_linux_clut224.o.d drivers/video/logo/logo_linux_clut224.o 'gcc -Wp,-MD,drivers/video/logo/.logo_linux_clut224.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-protot

>   LD      drivers/video/logo/built-in.o
>   CC      drivers/video/matrox/matroxfb_base.o
> In file included from drivers/video/matrox/matroxfb_base.c:105:
> drivers/video/matrox/matroxfb_base.h:52: video/fbcon.h: No such file or directory

I just sent email there yesterday with URL of matroxfb patch I sent to 
Linus for inclusion.

ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-stripdown-2.5.70.gz

                                                    Petr Vandrovec
                                                    

