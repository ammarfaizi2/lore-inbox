Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVABVmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVABVmW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 16:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVABVmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 16:42:22 -0500
Received: from holomorphy.com ([207.189.100.168]:64405 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261337AbVABVmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 16:42:19 -0500
Date: Sun, 2 Jan 2005 13:42:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050102214211.GM29332@holomorphy.com>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102212427.GG2818@pclin040.win.tue.nl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 10:24:27PM +0100, Andries Brouwer wrote:
> You are an optimist. I think reality is different.
> You change some stuff. The bad mistakes are discovered very soon.
> Some subtler things or some things that occur only in special
> configurations or under special conditions or just with
> very low probability may not be noticed until much later.
> So, your changes have a wake behind them that is wide the first
> few days and becomes thinner and thinner over time. Nontrivial
> changes may have bugs discovered after two or three years.
> If a kernel is set apart and called "stable", then it is not,
> but it will become more and more stable over time, until after
> two or three years only very few unknown problems are encountered.
> If you come with a new kernel every month, then you get
> the stability that the "stable" kernel has after less than a month,
> which is not particularly stable.

This is not optimism. This is experience. Every ``stable'' kernel I've
seen is a pile of incredibly stale code where vi'ing any file in it
instantly reveals numerous months or years old bugs fixed upstream.
What is gained in terms of reducing the risk of regressions is more
than lost by the loss of critical examination and by a long longshot.

-- wli
