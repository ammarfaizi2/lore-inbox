Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271811AbTGRQK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271800AbTGRQIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:08:50 -0400
Received: from mirapoint3.brutele.be ([212.68.203.242]:1375 "EHLO
	mirapoint3.brutele.be") by vger.kernel.org with ESMTP
	id S269900AbTGRQHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:07:01 -0400
Date: Fri, 18 Jul 2003 18:21:56 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ide-scsi in 2.6.0 ?
Message-ID: <20030718162156.GA2946@gentoo>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux gentoo 2.6.0-test1-ac2
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

I have a problem with ide-scsi

i put ide-scsi=/dev/hdc  in the "append"  of my grub configuration.

but, with dmesg, i can see, that i have a problem with this argument,
because the kernel tells me, than it's a bad option.

my error : ide_setup: ide-scsi=/dev/hdc -- BAD OPTION

A solution ?

Thanks

Stephane Wirtel

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
GPG ID : 1024D/C9C16DA7 | 5331 0B5B 21F0 0363 EACD  B73E 3D11 E5BC C9C1 6DA7


