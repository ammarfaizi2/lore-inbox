Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311452AbSCSRGt>; Tue, 19 Mar 2002 12:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311453AbSCSRGj>; Tue, 19 Mar 2002 12:06:39 -0500
Received: from are.twiddle.net ([64.81.246.98]:26250 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S311452AbSCSRG3>;
	Tue, 19 Mar 2002 12:06:29 -0500
Date: Tue, 19 Mar 2002 09:05:59 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, davidm@hpl.hp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas
Message-ID: <20020319090559.A6266@twiddle.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Rusty Russell <rusty@rustcorp.com.au>, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020318083511.A19810@wotan.suse.de> <E16n74r-00024V-00@wagner.rustcorp.com.au> <20020319011534.A32751@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 01:15:34AM +0100, Andi Kleen wrote:
> That would be the idea. gcc would learn how to use the %gs segment prefix
> (similar to the equivalent feature in Windows compilers).

Yep.  There are vague plans to do just that.


r~
