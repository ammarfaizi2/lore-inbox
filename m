Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264521AbTEJWs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 18:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTEJWs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 18:48:56 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:58263 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP id S264521AbTEJWsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 18:48:55 -0400
Message-ID: <3EBD84CA.609@attbi.com>
Date: Sat, 10 May 2003 16:01:30 -0700
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.4a) Gecko/20030403
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.69-bk4 -- drivers/video/valkyriefb.c:69:25: video/fbcon.h: No
 such file or directory
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_FB=y
CCONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y
CONFIG_FB_OF=y

CONFIG_FB_CONTROL=y
CONFIG_FB_PLATINUM=y
CONFIG_FB_VALKYRIE=y
CONFIG_FB_CT65550=y
CONFIG_FB_IMSTT=y
CONFIG_FB_RADEON=y

   gcc -Wp,-MD,drivers/video/.valkyriefb.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-tr
igraphs -O2 -fno-strict-aliasing -fno-common -Iarch/ppc -msoft-float 
-pipe -ffixed-r2 -Wno-uninitial
ized -mmultiple -mstring -fomit-frame-pointer -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=va
lkyriefb -DKBUILD_MODNAME=valkyriefb -c -o drivers/video/valkyriefb.o 
drivers/video/valkyriefb.c
drivers/video/valkyriefb.c:69:25: video/fbcon.h: No such file or directory
drivers/video/valkyriefb.c:70:30: video/fbcon-cfb8.h: No such file or 
directory
drivers/video/valkyriefb.c:71:31: video/fbcon-cfb16.h: No such file or 
directory
drivers/video/valkyriefb.c:72:28: video/macmodes.h: No such file or 
directory
In file included from drivers/video/valkyriefb.c:74:

