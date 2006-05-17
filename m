Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWEQNYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWEQNYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWEQNYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:24:05 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:42448 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932265AbWEQNYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:24:04 -0400
Date: Wed, 17 May 2006 09:24:03 -0400
To: linux cbon <linuxcbon@yahoo.fr>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
Message-ID: <20060517132403.GB23933@csclub.uwaterloo.ca>
References: <200605171218.k4HCIt4L013978@turing-police.cc.vt.edu> <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 02:39:37PM +0200, linux cbon wrote:
> If we have a new window system, shall all applications
> be rewritten ?

Unless you make your new system compatible with X, then all X
applications must be rewritten.

> My idea is that the kernel should include universal
> graphical support.
> And then we would NOT need ANY window system AT ALL.
> We wouldnt have 2 os (kernel and X) at the same time
> like now.
> It would be faster, simpler, easier to manage etc.

So if I get a new video card I have to get a new kernel?  Why can't I
just get an updated display system if my kernel works just fine.  RIght
now I can boot any VGA compatible card (and many others) to text mode
and work on my system, while I figure out how to get X going on my new
card.  If it was all in the kernel I am screwed if the kernel doesn't
yet support doing graphics on my new card.  I know that problem from
using Windows, although at least it eventually got better at falling
back to VGA only mode if it couldn't work with a new card.

Len Sorensen
