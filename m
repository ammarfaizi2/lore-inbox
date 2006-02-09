Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWBIKbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWBIKbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWBIKbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:31:17 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:24794 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030330AbWBIKbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:31:16 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 09 Feb 2006 11:29:28 +0100
To: schilling@fokus.fraunhofer.de, peter.read@gmail.com,
       matthias.andree@gmx.de, lsorense@csclub.uwaterloo.ca,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EB1988.nail7EL2I7AN6@burner>
References: <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
 <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208210219.GB9166@DervishD>
 <20060208211455.GC2480@csclub.uwaterloo.ca>
In-Reply-To: <20060208211455.GC2480@csclub.uwaterloo.ca>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsorense@csclub.uwaterloo.ca (Lennart Sorensen) wrote:

> Hmm, perhaps what should be done is that someone needs to write and
> maintain a patch that linux users can apply to cdrecord (since other OSs
> are different and hence have no reason to use such a patch), to make it
> behave in a manner which is sane on linux.  It should of course be
> clearly marked as having been changed in such a way.  It should use udev
> if available and HAL and whatever else is appropriate on a modern linux
> system, and if on an old system it should at least not break the
> interfaces that already worked on those systems in cdrecord.

Unfortunately is it a matter oif facts that all known patches for cdrecord
break more things than they claim to fix.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
