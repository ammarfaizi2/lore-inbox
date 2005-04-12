Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVDLA2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVDLA2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVDLA2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:28:46 -0400
Received: from ciistr2.ist.utl.pt ([193.136.128.2]:50834 "EHLO
	ciistr2.ist.utl.pt") by vger.kernel.org with ESMTP id S261807AbVDLA2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:28:34 -0400
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Processes stuck on D state on Dual Opteron
Date: Tue, 12 Apr 2005 01:22:47 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <200504111505.44284.ctpm@rnl.ist.utl.pt> <425B013A.5020108@yahoo.com.au>
In-Reply-To: <425B013A.5020108@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504120122.48168.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 11 April 2005 23:59, Nick Piggin wrote:
>
> >   OK, I'll try them in a few minutes and report back.
>
> I'm not overly hopeful. If they fix the problem, then it's likely
> that the real bug is hidden.
>

  Well, the thing is, they do fix the problem. Or at least they hide it very 
well ;-)

  It has been running for more than 5 hours now with stress with no problems 
and no stuck processes.

  I think I'm going to give a try to Neil's patch, but I'll have to apply some 
patches from -mm.

 Thanks

Claudio

