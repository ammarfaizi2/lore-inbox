Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUHXNIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUHXNIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUHXNIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:08:38 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:15082 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267739AbUHXNIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:08:32 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 24 Aug 2004 15:07:31 +0200
To: schilling@fokus.fraunhofer.de, der.eremit@email.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-ID: <412B3D93.nailBKG21RB5G@burner>
References: <2wAWW-12a-11@gated-at.bofh.it>
 <E1BzayM-00005W-Oc@localhost>
In-Reply-To: <E1BzayM-00005W-Oc@localhost>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Schmidt <der.eremit@email.de> wrote:

> On Tue, 24 Aug 2004 06:20:06 +0200, you wrote in linux.kernel:
>
> > Dou you know of any other system where you can say:
> >
> > 	Print me a strack trace with symbols for all processes on this
> > 	computer (even stripped ones) that call gettimeofday() within the
> > 	next few seconds.
>
> Well, this is by far off-topic here now, but how does this solve
> the general problem of knowing that gettimeofday() might be a
> problem in the given situation? But yeah, once you know that,
> the functionality is useful, no doubt.

If you did not get it yet, it's an example to show what may be done.
There are many more features. Just fetch the

	"Solaris Dynamic Tracing Guide" 

manual as PDF for more information - it's 300 pages.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
