Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270430AbTHGSVN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270432AbTHGSVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:21:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5357 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270430AbTHGSVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:21:05 -0400
Date: Thu, 7 Aug 2003 20:20:39 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mike Castle <dalgoda@ix.netcom.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA problem with 2.6.0-test1
In-Reply-To: <sifa01x0g7.ln2@thune.mrc-home.org>
Message-ID: <Pine.SOL.4.30.0308072019250.3600-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can be buggy drive's firmware or bug in smartmontools (unlikely)...

--bartlomiej

On Thu, 7 Aug 2003, Mike Castle wrote:

> In article <Pine.SOL.4.30.0308061750260.22000-100000@mion.elka.pw.edu.pl>,
> Bartlomiej Zolnierkiewicz  <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> >
> >You can also install smartmontools (http://smartmontools.sf.net/)
> >and check your drives (if they support SMART of course).
>
>
> Point of interest:  I just had a Maxtor drive go bad on me recently.  Their
> diag tools caught it, as did my ear (made a nice clunking noise :-).  But
> SMART didn't report a thing, and I looked hard too.  :-/
>
> mrc


