Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266913AbUAXLWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 06:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUAXLWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 06:22:05 -0500
Received: from gizmo03bw.bigpond.com ([144.140.70.13]:51426 "HELO
	gizmo03bw.bigpond.com") by vger.kernel.org with SMTP
	id S266913AbUAXLWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 06:22:03 -0500
Message-ID: <40125540.A33B8AB2@eyal.emu.id.au>
Date: Sat, 24 Jan 2004 22:21:36 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.25-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre7
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Here goes -pre number 7 of 2.4.25 series.

cp aty128fb.o clgenfb.o cyber2000fb.o fbcon-afb.o fbcon-cfb16.o
fbcon-cfb2.o fbc
on-cfb24.o fbcon-cfb32.o fbcon-cfb4.o fbcon-cfb8.o fbcon-hga.o
fbcon-ilbm.o fbco
n-iplan2p2.o fbcon-iplan2p4.o fbcon-iplan2p8.o fbcon-mac.o fbcon-mfb.o
fbcon-vga
-planes.o fbcon-vga.o fbgen.o hgafb.o it8181fb.o mdacon.o neofb.o
pm2fb.o pm3fb.
o radeonfb.o sstfb.o tdfxfb.o tridentfb.o vfb.o vga16fb.o
/lib/modules/2.4.25-pr
e7/kernel/drivers/video/
cp: cannot stat `it8181fb.o': No such file or directory
make[2]: *** [_modinst__] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/video'

There are no it8181fb.* files there.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
