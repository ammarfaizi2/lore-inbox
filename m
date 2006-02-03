Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWBCN4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWBCN4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWBCN4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:56:45 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:10200 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750794AbWBCN4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:56:44 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 14:54:12 +0100
To: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com, 7eggert@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E36084.nail5CAJ14LO3@burner>
References: <5yJ3h-6er-11@gated-at.bofh.it>
 <5yVQR-8bI-39@gated-at.bofh.it> <5yWah-99-29@gated-at.bofh.it>
 <5yWts-OZ-21@gated-at.bofh.it> <5z1Wj-TN-31@gated-at.bofh.it>
 <5zer2-1BC-29@gated-at.bofh.it> <5AFHY-5jd-23@gated-at.bofh.it>
 <5ALb5-5kV-43@gated-at.bofh.it> <5B15G-39W-17@gated-at.bofh.it>
 <5B1Im-4cW-7@gated-at.bofh.it> <5B3TN-7AV-9@gated-at.bofh.it>
 <5Bs5Z-1BT-17@gated-at.bofh.it> <5BJgx-1fE-13@gated-at.bofh.it>
 <E1F4nt5-00014L-Ry@be1.lrz>
In-Reply-To: <E1F4nt5-00014L-Ry@be1.lrz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org> wrote:

> If you
> - add a SCSI controler
> - add an USB burner
> - connect to an aoe/iscsi-device(?),
> it will get a random ID. If you reboot (or just plug out/plug in), it will
> be randomly different. The same thing may happen after a system upgrade,
> possibly depending on the linker.

This is a limitation of the implementation used on Linux and not true for e.g. 
Solaris.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
