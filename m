Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSKINh1>; Sat, 9 Nov 2002 08:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265191AbSKINh1>; Sat, 9 Nov 2002 08:37:27 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:51949 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP
	id <S265108AbSKINh0>; Sat, 9 Nov 2002 08:37:26 -0500
Date: Sat, 9 Nov 2002 14:44:45 +0100
From: Romain Lievin <rlievin@free.fr>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kconfig (qconf): bug ?
Message-ID: <20021109134444.GB9480@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

BTW, I noticed something weird with Qconf. I don't know whether it's a
bug or a mis-behaviour...

Once you have a .config file in /usr/src/linux and if you attempt to load
another config file, Qconf will not load my settings.
If you does not have the .config file yet (freshen install) and I attempt to
load my config file,  Qconf will load it fine...

Well, how does conf_read() work ? What does it do exactly ?

Romain.
-- 
Romain Lievin, aka 'roms'  	<roms@lpg.ticalc.org>
Web site 			<http://lpg.ticalc.org/prj_tilp>
"Linux, y'a moins bien mais c'est plus cher !"














