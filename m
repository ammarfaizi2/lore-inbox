Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318749AbSHGQ6V>; Wed, 7 Aug 2002 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318750AbSHGQ6V>; Wed, 7 Aug 2002 12:58:21 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:2618 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318749AbSHGQ6V>;
	Wed, 7 Aug 2002 12:58:21 -0400
Date: Wed, 7 Aug 2002 19:00:41 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: <davidsen@tmr.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Why 'mrproper'?
Message-ID: <20020807170041.GA259@win.tue.nl>
References: <Pine.LNX.4.33.0208070851230.2421-100000@iccarus.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208070851230.2421-100000@iccarus.tmr.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 08:55:25AM -0400, Bill Davidsen wrote:

> Having started out on the four floppy MCC "distribution" of Linux,
> building kernels clean with 'make distclean,' can someone provide a quick
> historical note as to what mrproper buys? A quick look at the tree after
> each didn't tell me much.

Funny that you ask this question first now.
mrproper came in 0.99p7
distclean came in 0.99p14 as a synonym for mrproper.

