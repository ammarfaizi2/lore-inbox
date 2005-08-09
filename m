Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVHIW56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVHIW56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 18:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVHIW56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 18:57:58 -0400
Received: from ns2.suse.de ([195.135.220.15]:12445 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750955AbVHIW55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 18:57:57 -0400
Date: Wed, 10 Aug 2005 00:57:56 +0200
From: Andi Kleen <ak@suse.de>
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: smbus driver for ati xpress 200m
Message-ID: <20050809225756.GA19772@wotan.suse.de>
References: <42F8EB66.8020002@fujitsu-siemens.com> <86802c440508091150609eecca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440508091150609eecca@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 11:50:53AM -0700, yhlu wrote:
> anyone is working on add driver for ati xpress 200m?
> 
> without that My turion notebook, can not work read the battery status.

Normally this should be done in ACPI battery.c

-Andi
