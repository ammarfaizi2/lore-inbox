Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264546AbSIRESK>; Wed, 18 Sep 2002 00:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264555AbSIRESK>; Wed, 18 Sep 2002 00:18:10 -0400
Received: from holomorphy.com ([66.224.33.161]:63719 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264546AbSIRESJ>;
	Wed, 18 Sep 2002 00:18:09 -0400
Date: Tue, 17 Sep 2002 21:18:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  September 18, 2002
Message-ID: <20020918041852.GQ3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3D87C1C6.21599.33750A21@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D87C1C6.21599.33750A21@localhost>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 11:59:02PM -0400, Guillaume Boissiere wrote:
> o Alpha       Parallelizing page replacement                  (William Lee Irwin)

Andrew Morton has either adapted, rewritten, or both the code I'd
devised for this vs. 2.4.x-based rmap involving the pagemap_lru_lock,
and that code is in 2.5.3x-mm. Momchil Velikov also originally devised
the ratcache early in 2.5.x. So this is a bit beyond alpha, and
probably needs Andrew Morton's, Momchil Velikov's, and Dave Hansen's
names on it, possibly even removing mine.


Thanks,
Bill
