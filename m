Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbSLSLHH>; Thu, 19 Dec 2002 06:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbSLSLHH>; Thu, 19 Dec 2002 06:07:07 -0500
Received: from holomorphy.com ([66.224.33.161]:63936 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267599AbSLSLHF>;
	Thu, 19 Dec 2002 06:07:05 -0500
Date: Thu, 19 Dec 2002 03:14:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] 2.5.52-lsm1
Message-ID: <20021219111433.GM1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-security-module@wirex.com, linux-kernel@vger.kernel.org
References: <20021219025123.A23371@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219025123.A23371@figure1.int.wirex.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 02:51:23AM -0800, Chris Wright wrote:
> The Linux Security Modules project provides a lightweight, general
> purpose framework for access control.  The LSM interface enables
> security policies to be developed as loadable kernel modules.
> See http://lsm.immunix.org for more information.
> 2.5.52-lsm1 patch released.  This is a rebase up to 2.5.52 as well as
> numerous module updates and bugfixes.  The interface has changed, and
> the hooks are controlled with CONFIG_SECURITY now.  Currently LIDS and
> DTE will not compile.
> Full lsm-2.5 patch (LSM + all modules) is available at:
> 	http://lsm.immunix.org/patches/2.5/2.5.52/patch-2.5.52-lsm1.gz
> The whole ChangeLog for this release is at:
> 	http://lsm.immunix.org/patches/2.5/2.5.52/ChangeLog-2.5.52-lsm1
> The LSM 2.5 BK tree can be pulled from:
>         bk://lsm.bkbits.net/lsm-2.5

Forgive my ignorance (if this applies) but I recently submitted a patch
acked by both you and gregkh. If there are difficulties with it I'd be
much obliged to hear of them and will resolve them with the utmost
urgency. Aside from that my only concern is that it did not appear in
your changelog. If it's been deferred to a later push that is also okay
with me.

Linus, please do not take this concern as any opposition to the
inclusion of this patch and review it entirely independently of this.
I'm only exercising due diligence with respect to an API update I sent
which should have zero impact on correct functionality, and the omission
of my patch has no implications wrt. the properness of the changes sent
in this submission.

Thanks,
Bill
