Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263721AbTICRWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTICRVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:21:20 -0400
Received: from holomorphy.com ([66.224.33.161]:6281 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263659AbTICRUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:20:14 -0400
Date: Wed, 3 Sep 2003 10:21:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Cliff White <cliffw@osdl.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: UP Regression (was) Re: Scaling noise
Message-ID: <20030903172104.GO4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Cliff White <cliffw@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel@vger.kernel.org
References: <3F55907B.1030700@cyberone.com.au> <200309031551.h83Fpu413835@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309031551.h83Fpu413835@mail.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:51:56AM -0700, Cliff White wrote:
> On the Scalable Test Platform, running osdl-aim-7,  for the
> UP case, 2.4 is a bit better than 2.6, this is consistent across
> many runs. For SMP, 2.6 is better, but the delta is rather
> small, until we get to 8 CPUS. We have a lot of un-parsed data from other
> tests - might be some trends there also.
> See http://developer.osdl.org/cliffw/reaim/index.html 
> 2.4 kernels are at the bottom of the page.

Do you have profile data for these runs? Also, that webpage doesn't
have 2.4.x results.


-- wli
