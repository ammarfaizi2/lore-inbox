Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVABVYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVABVYg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 16:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVABVYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 16:24:36 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:772 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261336AbVABVYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 16:24:32 -0500
Date: Sun, 2 Jan 2005 22:24:27 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050102212427.GG2818@pclin040.win.tue.nl>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102203615.GL29332@holomorphy.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: SINECTIS: pastinakel.tue.nl 1114; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 12:36:15PM -0800, William Lee Irwin III wrote:

> There is a standard. Breaking things and hoping someone cleans up
> later doesn't work. So it has to be stable all the time anyway, and
> this is one of the observations upon which the "2.6 forever" theme is
> based.

You are an optimist. I think reality is different.

You change some stuff. The bad mistakes are discovered very soon.
Some subtler things or some things that occur only in special
configurations or under special conditions or just with
very low probability may not be noticed until much later.

So, your changes have a wake behind them that is wide the first
few days and becomes thinner and thinner over time. Nontrivial
changes may have bugs discovered after two or three years.

If a kernel is set apart and called "stable", then it is not,
but it will become more and more stable over time, until after
two or three years only very few unknown problems are encountered.

If you come with a new kernel every month, then you get
the stability that the "stable" kernel has after less than a month,
which is not particularly stable.

Andries
