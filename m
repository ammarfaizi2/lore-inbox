Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUJQMWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUJQMWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 08:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269104AbUJQMWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 08:22:53 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:2314 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261610AbUJQMWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 08:22:52 -0400
Date: Sun, 17 Oct 2004 14:22:46 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: David Schwartz <davids@webmaster.com>
Cc: aebr@win.tue.nl, mark@mark.mielke.cc,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017122246.GA19284@pclin040.win.tue.nl>
References: <20041016182544.GC3379@pclin040.win.tue.nl> <MDEHLPKNGKAHNMBLJOLKKEONPAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEONPAAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 05:28:22PM -0700, David Schwartz wrote:

> > > Linux's behavior is correct in the literal sense that it is
> > > doing something
> > > that is allowed. It's incorrect in the sense that it's sub-optimal.
> >
> > "Allowed" by whom? By you?
> 
> 	I clearly explained what I meant in context that you snipped. In summary, I
> mean 'allowed' in the sense that it's not prohibited by the standard

Yes, but it is prohibited by the standard in case you refer to POSIX.
I quoted chapter and verse. If you refer to a different standard, be explicit.

Whether the standard is reasonable or not, and whether we care or not,
that is a different matter.  But you must keep the facts straight.

Andries
