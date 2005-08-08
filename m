Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVHHQsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVHHQsB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVHHQsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:48:01 -0400
Received: from hockin.org ([66.35.79.110]:11997 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S932111AbVHHQsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:48:01 -0400
Date: Mon, 8 Aug 2005 09:47:54 -0700
From: Tim Hockin <thockin@hockin.org>
To: Andi Kleen <ak@suse.de>
Cc: Erick Turnquist <jhujhiti@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
Message-ID: <20050808164754.GA26031@hockin.org>
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel> <p73mznuc732.fsf@bragg.suse.de> <20050807174811.GA31006@hockin.org> <20050808120125.GD19170@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808120125.GD19170@wotan.suse.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 02:01:25PM +0200, Andi Kleen wrote:
> > Some BIOSes do not lock SMM, and you *could* turn it off at the chipset
> > level.
> 
> Doing so would be wasteful though. Both AMD and Intel CPUs need SMM code
> for the deeper C* sleep states.

Really?  I'm not too familiar with the deeper C states - what role does
SMM play?
