Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTDGXB5 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTDGXB4 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:01:56 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:24720 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263785AbTDGWzl (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 18:55:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nicholas Wourms <dragon@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: Interactivity backport to 2.4.20-ck*
Date: Tue, 8 Apr 2003 08:59:34 +1000
User-Agent: KMail/1.5.1
References: <200304072353.47664.kernel@kolivas.org> <200304072138.44957.m.c.p@wolk-project.de> <3E91D99E.3090807@gentoo.org>
In-Reply-To: <3E91D99E.3090807@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304080859.34822.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003 06:03, Nicholas Wourms wrote:
> Marc-Christian Petersen wrote:
> > On Monday 07 April 2003 21:30, Josh McKinney wrote:
> >
> > Hi Josh,
> >
> >>>Yeah sure here:
> >>>http://kernel.kolivas.org/scheda3_ck4
> >
> >                                       ^^^^
> >
> >>Is this patch supposed to be against ck3?
> >
> > see? ;)
>
> Actually, the Makefile hunk in the patch would have one
> believe that it is against -ck3...

It's a simple minipatch against a 2.4.20 patched with the O(1),preempt,low 
latency combination which didn't change in ck4.

Con
