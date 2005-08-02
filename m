Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVHBOgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVHBOgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVHBOd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:33:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:40072 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261546AbVHBOb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:31:59 -0400
Date: Tue, 2 Aug 2005 16:31:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Lee Revell <rlrevell@joe-job.com>
cc: Pavel Machek <pavel@ucw.cz>, James Bruce <bruce@andrew.cmu.edu>,
       David Weinehall <tao@acc.umu.se>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
In-Reply-To: <1122991707.5490.32.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0508021626340.3743@scrub.home>
References: <20050730195116.GB9188@elf.ucw.cz>  <1122753864.14769.18.camel@mindpipe>
 <20050730201049.GE2093@elf.ucw.cz>  <42ED32D3.9070208@andrew.cmu.edu>
 <20050731211020.GB27433@elf.ucw.cz>  <42ED4CCF.6020803@andrew.cmu.edu>
 <20050731224752.GC27580@elf.ucw.cz>  <1122852234.13000.27.camel@mindpipe> 
 <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu> 
 <20050802112304.GA1308@elf.ucw.cz> <1122991707.5490.32.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2 Aug 2005, Lee Revell wrote:

> On Tue, 2005-08-02 at 13:23 +0200, Pavel Machek wrote:
> > As I said, I do not care about default value. And you should not care,
> > too, since distros are likely to pick their own defaults.
> 
> If the default value does not matter then the default should remain at
> 1000 so as to not violate the principle of least surprise for people who
> run "make oldconfig".  Why is this so hard for people to understand?

Because people who run "make oldconfig" are expected to have some clue 
about how to read help texts. Please get some, thanks.

bye, Roman

