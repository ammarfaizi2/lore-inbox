Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUBRNGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUBRNEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:04:08 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:27653 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S266905AbUBRNCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:02:52 -0500
Date: Wed, 18 Feb 2004 05:02:45 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Klaus Ethgen <Klaus@Ethgen.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [KERNEL] Re: [KERNEL] Re: TCP: Treason uncloaked DoS ??
Message-ID: <20040218130245.GA8482@dingdong.cryptoapps.com>
References: <20040218102725.GB3394@hathi.ethgen.de> <20040218105508.GA7320@dingdong.cryptoapps.com> <20040218124141.GA11303@hathi.ethgen.de> <20040218124859.GA8382@dingdong.cryptoapps.com> <20040218125731.GB11303@hathi.ethgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218125731.GB11303@hathi.ethgen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 01:57:31PM +0100, Klaus Ethgen wrote:

> After this tip that it could be tu do with the TC on the other
> interface I will try this out this night.

Last I checked the TC doesn't mess with the window size...  has this
changed?


