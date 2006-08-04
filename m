Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161437AbWHDXBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161437AbWHDXBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161572AbWHDXBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:01:40 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:13206 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1161437AbWHDXBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:01:39 -0400
Date: Sat, 5 Aug 2006 01:00:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Josh Boyer <jwboyer@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-ID: <20060804230017.GO25692@stusta.de>
References: <20060803204921.GA10935@kroah.com> <625fc13d0608031943m7fb60d1dwb11092fb413f7fc3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625fc13d0608031943m7fb60d1dwb11092fb413f7fc3@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 09:43:06PM -0500, Josh Boyer wrote:
> On 8/3/06, Greg KH <greg@kroah.com> wrote:
> >This is just a notice to everyone that Adrian is going to now be taking
> >over the 2.6.16-stable kernel branch, for him to maintain for as long as
> >he wants to.
> 
> Adrian, could you provide a bit of rationale as to why you want to do
> this?  I'm just curious.

A long-term maintained stable series was missing in the current 
development model.

The 2.6 series itself is theoretically a stable series, but the amount 
of regressions is too big for some users.

> josh

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

