Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbTCEC4S>; Tue, 4 Mar 2003 21:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTCEC4S>; Tue, 4 Mar 2003 21:56:18 -0500
Received: from tapu.f00f.org ([202.49.232.129]:23454 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267072AbTCEC4R>;
	Tue, 4 Mar 2003 21:56:17 -0500
Date: Tue, 4 Mar 2003 19:06:47 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>, Daniel Egger <degger@fhm.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel bloat 2.4 vs. 2.5
Message-ID: <20030305030647.GB28205@f00f.org>
References: <1046817738.4754.33.camel@sonja> <20030304154105.7a2db7fa.akpm@digeo.com> <20030305015957.GA27985@f00f.org> <1046830980.999.78.camel@phantasy.awol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046830980.999.78.camel@phantasy.awol.org>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 09:23:00PM -0500, Robert Love wrote:

> Ugh look at that increase in data.  Is this SMP?

UP ... no preempt.

As somene pointed out, kallsyms doesn't help, so let me rebuild and
compare again.


  --cw
