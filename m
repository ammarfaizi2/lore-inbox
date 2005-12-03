Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVLCBo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVLCBo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVLCBo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:44:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:31369 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751141AbVLCBo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:44:27 -0500
Date: Sat, 3 Dec 2005 02:44:22 +0100
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fls in asm for x86_64
Message-ID: <20051203014421.GH9766@wotan.suse.de>
References: <20051202162240.746c436e@localhost.localdomain> <20051202162436.2a96313b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202162436.2a96313b@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 04:24:36PM -0800, Stephen Hemminger wrote:
> Use single instruction for find largest set bit on x86_64.

Thanks queued.

-Andi
