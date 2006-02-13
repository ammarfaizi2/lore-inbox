Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWBMPIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWBMPIv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWBMPIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:08:50 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:15779 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932408AbWBMPIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:08:49 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 13 Feb 2006 16:07:16 +0100
To: tytso@mit.edu, schilling@fokus.fraunhofer.de
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F0A0A4.nailKUSSSCJAI@burner>
References: <mj+md-20060210.123726.23341.atrey@ucw.cz>
 <43EC8E18.nailISDJTQDBG@burner>
 <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
 <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org>
 <43ECA3FC.nailJGC110XNX@burner> <20060210145238.GC18707@thunk.org>
 <43ECA934.nailJHD2NPUCH@burner> <20060210155711.GA11566@thunk.org>
 <43F0634C.nailKUS6JSGJH@burner> <20060213121503.GA31745@thunk.org>
In-Reply-To: <20060213121503.GA31745@thunk.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Mon, Feb 13, 2006 at 11:45:32AM +0100, Joerg Schilling wrote:
> > If you did try to understand the reason why I did introduce the POSIX
> > claim, you would know that if Linux did try to follow the POSIX rule,
> > a side effect would be that removable devices need to have a stable 
> > mapping in the kernel
>
> It is _not_ a POSIX rule, as I and others have shown.  You claimed it
> was required by POSIX, but you are quite clearly incorrect.  It has
> never worked that way with Unix systems, and POSIX was always designed
> to codify existing practice.  On Unix systems fixed disks would and
> did have their devices numbering schemes move around under a number of
> conditions.

If you believe this, pleace give evidence.

I was quoting POSIX documents which prove my claims......
Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
