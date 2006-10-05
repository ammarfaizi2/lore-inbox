Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWJEXFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWJEXFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWJEXFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:05:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:45726 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932402AbWJEXFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:05:14 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
Date: Fri, 6 Oct 2006 01:05:10 +0200
User-Agent: KMail/1.9.3
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <200610051910.25418.ak@suse.de> <200610051927.27255.ak@suse.de> <Pine.LNX.4.64.0610051556330.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610051556330.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610060105.10357.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 00:59, Linus Torvalds wrote:
> 
> On Thu, 5 Oct 2006, Andi Kleen wrote:
> > 
> > Ok. Please drop them then.
> 
> Ok, done. Since they weren't the last commits in your branch, I had to do 
> a certain amount of hand-waving: I merged up to the commit preceding the 
> AC flag changes, and then I cherry-picked the one later commit separately.
> 
> So it's not a normal merge, since I wanted to avoid those two commits.
> 
> I've pushed out the result, you should check it out 

Looks good thanks.

> (and drop the top  
> three commits on your head once you're ok with my result, since they won't 
> exist in my tree).

I only use temporary merge trees from quilt anyways, so it's fine
for me.

-Andi
