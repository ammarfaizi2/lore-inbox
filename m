Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVCYVJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVCYVJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVCYVJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:09:35 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54536 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261275AbVCYVJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:09:33 -0500
Date: Fri, 25 Mar 2005 21:07:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Message-ID: <20050325210743.E12715@flint.arm.linux.org.uk>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050324044114.5aa5b166.akpm@osdl.org> <a44ae5cd05032420122cd610bd@mail.gmail.com> <20050324202215.663bd8a9.akpm@osdl.org> <20050325073846.A18596@flint.arm.linux.org.uk> <1111784022.23430.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1111784022.23430.1.camel@mindpipe>; from rlrevell@joe-job.com on Fri, Mar 25, 2005 at 03:53:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 03:53:42PM -0500, Lee Revell wrote:
> On Fri, 2005-03-25 at 07:38 +0000, Russell King wrote:
> > Users need to be re-educated _not_ to use ksymoops.
> 
> How about changing the fscking docs to not tell users to use it?

Would be useful.  The "fscking" problem is that no one actually owns the
documents, so there's no central focus to keep them up to date.

Maybe we need a docfsck? 8)

I certainly don't have authority to tell x86 people not to use ksymoops.
Therefore, I think my suggested change (which up until recently I thought
was an ARM only problem) should be done by someone else.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
