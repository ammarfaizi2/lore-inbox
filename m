Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWCNWVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWCNWVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWCNWVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:21:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44557 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932544AbWCNWVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:21:40 -0500
Date: Tue, 14 Mar 2006 22:21:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Grant Coady <gcoady@gmail.com>
Cc: Willy Tarreau <willy@w.ods.org>, Arjan van de Ven <arjan@infradead.org>,
       j4K3xBl4sT3r <jakexblaster@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Which kernel is the best for a small linux system?
Message-ID: <20060314222131.GB3166@flint.arm.linux.org.uk>
Mail-Followup-To: Grant Coady <gcoady@gmail.com>,
	Willy Tarreau <willy@w.ods.org>,
	Arjan van de Ven <arjan@infradead.org>,
	j4K3xBl4sT3r <jakexblaster@gmail.com>, linux-kernel@vger.kernel.org
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com> <1142273212.3023.35.camel@laptopd505.fenrus.org> <20060314062144.GC21493@w.ods.org> <kv2d12131e73fjkp0hufomj152un5tbsj1@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kv2d12131e73fjkp0hufomj152un5tbsj1@4ax.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 09:03:39PM +1100, Grant Coady wrote:
> By stable I mean rate of change of codebase, patch volume per month,  
> 2.6 is orders of magnitude less stable than 2.4 by that simple measure.

That is no measure of stability.

If, say, I merge a large patch in order to support ARM SMP and Linus
takes that, let's say for the sake of argument that's a 10MB diff.
It doesn't touch anything other than files which are solely built or
used for the ARM architecture.

Are you going to claim that the kernel is, therefore, unstable on
x86?

So, by your very comment above, if all the updates to non-x86
architectures were prevented from happening in mainline, you'd have
a much more stable kernel.

Uh huh.  There's a saying about comparing apples and oranges which
springs to mind here - did you miss that lesson?

(Please do _not_ cc or reply directly to me in this thread - I'll
read replies from the mailing list, thanks.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
