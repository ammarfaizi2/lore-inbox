Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272950AbTHEXPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 19:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272974AbTHEXPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 19:15:24 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18194 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S272950AbTHEXPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 19:15:20 -0400
Date: Wed, 6 Aug 2003 01:15:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: B.Zolnierkiewicz@elka.pw.edu.pl, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix error return get/set_native_max functions
In-Reply-To: <UTC200308052008.h75K8aD22137.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0308060058120.717-100000@serv>
References: <UTC200308052008.h75K8aD22137.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 5 Aug 2003 Andries.Brouwer@cwi.nl wrote:

> > This change is okay, thanks.
> > However changing coding style is not...
> 
> An interesting remark.
> 
> I belong to the people who look at kernel source on a screen
> with 80 columns. Code that is wider and wraps is unreadable.

Get a better editor?
While I think 80 columns is a worthwhile goal, I don't see a good reason 
to wrap a random line only because it exceeds the limit by a few 
characters. What is especially annoying are patches with a one line fix
hidden within 10 other formatting changes (I've seen this already from 
you). Please respect others people code and try to avoid randoming 
formatting changes or at least keep them separate.

bye, Roman

