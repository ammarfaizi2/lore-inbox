Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318895AbSHEVoI>; Mon, 5 Aug 2002 17:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318897AbSHEVoI>; Mon, 5 Aug 2002 17:44:08 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:64006 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S318895AbSHEVoD> convert rfc822-to-8bit; Mon, 5 Aug 2002 17:44:03 -0400
Date: Mon, 5 Aug 2002 23:47:24 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <aia21@cantab.net>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] Patch: linux-2.5.30/fs/ntfs BUG_ON(cond1 ||
 cond2) bugs(!) and clean ups
In-Reply-To: <200208052129.OAA03065@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0208052334230.32276-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Adam J. Richter wrote:

> >Thanks for the patch. Patch accepted and committed to my tree. It will be
> >submitted with the next ntfs point release.
>
> 	Wow, thanks for the quick incorporation of my patch.

Just for the info. Along with other updates (few bits from 2.0.23, and
fixed kmap_pte and kmap_proto exports -- issue found by Jörg Prante) it is
also included in upcoming NTFS backport to 2.4.x. Version 2.0.23b should
be available within an hour.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku


