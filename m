Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbTAaAcC>; Thu, 30 Jan 2003 19:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267406AbTAaAcC>; Thu, 30 Jan 2003 19:32:02 -0500
Received: from are.twiddle.net ([64.81.246.98]:40583 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267403AbTAaAcB>;
	Thu, 30 Jan 2003 19:32:01 -0500
Date: Thu, 30 Jan 2003 16:41:20 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: frlock and barrier discussion
Message-ID: <20030130164120.A22148@twiddle.net>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Stephen Hemminger <shemminger@osdl.org>,
	Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net> <20030128230639.A17385@twiddle.net> <1043889355.10153.571.camel@dell_ss3.pdx.osdl.net> <20030129174133.A19912@twiddle.net> <20030130015219.GT1237@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030130015219.GT1237@dualathlon.random>; from andrea@suse.de on Thu, Jan 30, 2003 at 02:52:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2003 at 02:52:19AM +0100, Andrea Arcangeli wrote:
> you're missing xtimensec is a write.

Eh?  xtimensec is a register.



r~
