Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUH1Vl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUH1Vl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUH1Vlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:41:55 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:44672 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S268052AbUH1Vkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:40:46 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Date: Sat, 28 Aug 2004 17:41:36 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       clameter@sgi.com, ak@suse.de, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
References: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com> <20040827173641.5cfb79f6.akpm@osdl.org> <20040828010253.GA50329@muc.de>
In-Reply-To: <20040828010253.GA50329@muc.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408281741.36211.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Friday 27 August 2004 21:02, Andi Kleen wrote:
> Yep.  Good plan. atomic_long_t ?

Would it not be more C-ish as long_atomic_t?

Regards,

Daniel
