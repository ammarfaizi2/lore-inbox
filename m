Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWCHOgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWCHOgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWCHOgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:36:14 -0500
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:49894 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751400AbWCHOgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:36:14 -0500
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Reply-To: lee.schermerhorn@hp.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, 76306.1226@compuserve.com,
       torvalds@osdl.org, michaelc@cs.wisc.edu, jesper.juhl@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       James.Bottomley@steeleye.com
In-Reply-To: <440EA2A2.3040601@yahoo.com.au>
References: <200603080129_MC3-1-BA15-47C9@compuserve.com>
	 <440E969B.2080301@yahoo.com.au>	<20060308004659.163b6e29.akpm@osdl.org>
	 <440E9DBE.209@yahoo.com.au> <20060308011254.6cc7a190.akpm@osdl.org>
	 <440EA2A2.3040601@yahoo.com.au>
Content-Type: text/plain
Organization: LOSL, Nashua
Date: Wed, 08 Mar 2006 09:35:50 -0500
Message-Id: <1141828550.5225.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 20:23 +1100, Nick Piggin wrote:
> Andrew Morton wrote:
> 
> > Well yes, Lee sent the fix to the guy who he got the kernel release from in
> > the reasonable expectation that I'd take care of getting it to where it
> > needed to be.
> > 
> > Problem is, a) I screwed up, b) James screwed up and c) someone just
> > happened to change those few lines of code in that place within a few-day
> > window.
> > 
> > That triple-combo doesn't happen very often.
> > 
> 
> I guess what I'm advocating isn't foolproof either: the guy who wrote
> the patch might die (knock on wood) ;)

Thanks, Nick.  I'll remember that...  See you at OLS?

Lee

P.S. ;-)

