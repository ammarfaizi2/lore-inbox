Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVECQA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVECQA7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVECQA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:00:59 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64970 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261803AbVECQAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:00:55 -0400
Date: Tue, 3 May 2005 09:00:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050503160050.GO1221@smtp.west.cox.net>
References: <20050328173652.GA31354@linuxace.com> <20050328200243.C2222@flint.arm.linux.org.uk> <1115129833.4446.23.camel@hades.cambridge.redhat.com> <20050503151159.GL1221@smtp.west.cox.net> <1115133820.16187.4.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115133820.16187.4.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 04:23:40PM +0100, David Woodhouse wrote:
> On Tue, 2005-05-03 at 08:11 -0700, Tom Rini wrote:
> > I don't recall the problem well enough right now, but I'll go toss this
> > into a current git tree and let you know.
> 
> With what hardware are you testing? Was this really a NatSemi SuperIO
> chip, or was it a false positive in the detection?

This was on, I believe, the Motorola Sandpoint, which really does have a
NatSemi SuperIO.

-- 
Tom Rini
http://gate.crashing.org/~trini/
