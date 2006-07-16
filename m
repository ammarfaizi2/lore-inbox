Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWGQESZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWGQESZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 00:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWGQESZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 00:18:25 -0400
Received: from mailhost.terra.es ([213.4.149.12]:54990 "EHLO
	csmtpout2.frontal.correo") by vger.kernel.org with ESMTP
	id S932129AbWGQESY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 00:18:24 -0400
Date: Sun, 16 Jul 2006 18:55:30 +0200 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: Lexington Luthor <Lexington.Luthor@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-Id: <20060716190841.7392e0b2.grundig@teleline.es>
In-Reply-To: <e9dm0p$15s$1@sea.gmane.org>
References: <50d1c22d0607160545rd06c828n55ad9bbbd2f20bfd@mail.gmail.com>
	<20060716135038.GA8850@merlin.emma.line.org>
	<e9dm0p$15s$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 16 Jul 2006 16:29:24 +0100,
Lexington Luthor <Lexington.Luthor@gmail.com> escribió:

> I am just saddened that kernel decisions are motivated by politics and a 
> personal dislike of Hans Reiser rather than technical merit. :(

You (and every reiser4 fan that FUDs against linux developers just because
he can't understand why reiser4 still is not in) are seriously missing the
point.

Nobody is oppossing that reiser4 gets into the main linux tree. Let me
remember you that Linux has already merged quite a lot of filesystems,
including a lot of them that don't even matter in the real world (BeFS,
minix, ADFS, AFFS, EFS, VXFS, qnx4fs, sysvfs, ncpfs, codafs. Let me
also remember you that we have had other relevant filesystems for year
(reiser3, XFS, JFS), and everybody is ok with them, nobody is planning
to kill anyone.

With this short panoramic view of Linux I find shocking that people
dares even to _suggest_ that linux don't want to include a filesystem
for "political reasons".

Just to point you how wrong you are, compare OCFS2 and GFS. Both of them
are clustering filesystems, being OCFS from Oracle and GFS from Redhat.
_Both_ filesystems have been asked to be included in the main tree. As for
today, only OCFS2 is in (since 2.6.16, after several reviews and after
fixing their code like everyone else). GFS still isn't in and seems to
need work, but you won't see to the GFS technical leader tell everybody
(like Hans has done here) that Linux politics don't allow GFS to go in.
Instead of wining, they just go back to work on their issues.
