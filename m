Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270882AbTGVRO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 13:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270883AbTGVRO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 13:14:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:61358 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270882AbTGVROY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 13:14:24 -0400
Date: Tue, 22 Jul 2003 22:58:59 +0530
From: Apurva Mehta <apurva@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-ID: <20030722172858.GB2880@home.woodlands>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030722013443.GA18184@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722013443.GA18184@netnation.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Simon Kirby <sim@netnation.com> [2003-07-22 11:50]:
> I keep seeing cases where browsing in mozilla / galeon will suck away all
> CPU from X updating the mouse, xmms playing, etc., for about a second as
> Mozilla renders a page (which should take 50 ms to render, but anyway..).

I do not have any problems with mouse response, but xmms sure does
skip a whole lot more on my 2.6.0-test1 running on a PIII 500 MHz, 192
MB RAM. 

I usually run Opera and the skipping occurs often while switching
between tabs with the mouse (not when it is done with the keyboard).

Also, severe xmms skipping occurs while scrolling through PDF files
(in Acrobat) while the first few seconds of a song are playing. The
song virtually stops while I scroll. After the song plays for a bit,
scrolling through a PDF makes no difference.

Sometimes, xmms pops up in between songs saying that it could not
detect the audio device! This occurs mainly during heavy disk i/o or
cpu usage.
 
> .. but there never used to be such a problem in 2.2 and 2.4 kernels.
> All processes (X, galeon, xmms) are running with the default nice of
> 0.

Same here.. 
 
> Is anybody else seeing this or is it something to do with my setup here?

Apparently it is not just you :) 

	- Apurva
