Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUHZL5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUHZL5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUHZL5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:57:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40679 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268704AbUHZLzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:55:39 -0400
Date: Wed, 25 Aug 2004 00:48:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Wes Felter <wmf@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP cpu deep sleep
Message-ID: <20040824224844.GA709@openzaurus.ucw.cz>
References: <1092989207.18275.14.camel@linux.local> <pan.2004.08.20.16.44.39.888193@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.08.20.16.44.39.888193@austin.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> SMP Intel systems don't support any low-power modes besides HLT. AMD's
> documentation says that Opterons support voltage/frequency scaling (aka
> Cool 'n' Quiet), but AFAICT the documentation is wrong. In summary, you

I believe docs is right here. See archives, it looks like Paul
 is actually testing pn-k8 on smp machines.

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

