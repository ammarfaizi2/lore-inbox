Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132576AbRDWXrn>; Mon, 23 Apr 2001 19:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbRDWXrd>; Mon, 23 Apr 2001 19:47:33 -0400
Received: from www.resilience.com ([209.245.157.1]:36741 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S132576AbRDWXra>; Mon, 23 Apr 2001 19:47:30 -0400
Mime-Version: 1.0
Message-Id: <p05100301b70a6f4180e9@[209.245.157.5]>
In-Reply-To: <13243.988067416@ocs3.ocs-net>
In-Reply-To: <13243.988067416@ocs3.ocs-net>
Date: Mon, 23 Apr 2001 16:47:20 -0700
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: PATCH 2.4.4.3: 3rdparty driver support for kbuild
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:10 AM +1000 4/24/01, Keith Owens wrote:
> >I don't see how multiple source trees can be merged automatically with
>>100% accuracy. 
>
>I agree, multiple source trees only work 100% for non-overlapping code.
>It does not matter how you implement separate source, the moment it
>overlaps you need human intervention.  That is true for my makefile-2.5
>as well as your Perl method.

Where "non-overlapping" needs to be construed broadly to include "not logically conflicting", and not merely as overlapping diffs.
-- 
/Jonathan Lundell.
