Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTJNNUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 09:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTJNNUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 09:20:10 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:46209 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262386AbTJNNUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 09:20:07 -0400
Date: Tue, 14 Oct 2003 14:20:59 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310141320.h9EDKx5r001589@81-2-122-30.bradfords.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031014110820.GN16158@holomorphy.com>
References: <20031014105514.GH765@holomorphy.com>
 <200310141101.h9EB10sB001460@81-2-122-30.bradfords.org.uk>
 <20031014110820.GN16158@holomorphy.com>
Subject: Re: mem=16MB laptop testing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from William Lee Irwin III <wli@holomorphy.com>:
> At some point in the past, I wrote:
> >> (g) X isn't terribly swift; it's slower than I remember old Sun IPC's
> >> 	being, though they had 24MB RAM. OTOH luserspace is much more
> >> 	bloated these days. zsh alone is at least 3 times the size of
> >> 	ksh, which I used back then. fvwm2 is a lot bigger than fvwm1.
> >> 	And so on and so forth. I guess the upshot is "unbloating" the
> >> 	kernel wouldn't do much good anyway, since luserspace isn't in
> >> 	any kind of shape to run in this kind of environment anymore either.
> 
> On Tue, Oct 14, 2003 at 12:01:00PM +0100, John Bradford wrote:
> > Depends on what you consider usable.  I thought X worked pretty well
> > in swapless 8MB last time I tried it, (last year, around 2.5.40).
> > Admittedly that was only running a few xterms locally.  A 4MB + 20MB
> > swap box was suprisingly usable for fairly intense remote applications
> > over a compressed 9600 bps serial link.
> 
> It's not that it's particularly unusable, it was merely substantially
> slower than vaguely comparable machines I remember from way back when.

Ah, OK.  Quite possibly my subjective observation was biased, simply
because I was expecting it to perform badly :-).

John.
