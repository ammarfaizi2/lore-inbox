Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbULLAND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbULLAND (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 19:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbULLAND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 19:13:03 -0500
Received: from holomorphy.com ([207.189.100.168]:63388 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262044AbULLAMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 19:12:52 -0500
Date: Sat, 11 Dec 2004 16:12:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041212001241.GX2714@holomorphy.com>
References: <20041201104820.1.patchmail@tglx> <20041210163247.GM2714@holomorphy.com> <1102697553.3306.91.camel@tglx.tec.linutronix.de> <20041210174938.GX16322@dualathlon.random> <20041210175706.GS2714@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210175706.GS2714@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 09:57:06AM -0800, William Lee Irwin III wrote:
> The easy way to fix that issue is to take the whole diff and break off
> pieces, with the remainder always as the last patch. That way the whole
> set of changes stays pending and appears intact at the end of the series.
> I will personally be held responsible for identifying the causes of
> behavioral changes in the OOM killer, and am having to investigate
> several instances of bad OOM killer behavior already, so I have to do
> this anyway, and so it might as well be done for mainline.

Actually, I'm dropping my whole public effort and am going to stick to
using what I do in this respect for internal testing etc.


-- wli
