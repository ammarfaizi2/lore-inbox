Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVLOXgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVLOXgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 18:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVLOXgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 18:36:52 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:32175 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751206AbVLOXgv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 18:36:51 -0500
From: Ismail Donmez <ismail@uludag.org.tr>
Organization: TUBITAK/UEKAE
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 01:36:31 +0200
User-Agent: KMail/1.9.1
References: <20051215212447.GR23349@stusta.de> <1134689197.12086.176.camel@mindpipe> <43A1E876.6050407@wolfmountaingroup.com>
In-Reply-To: <43A1E876.6050407@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512160136.31703.ismail@uludag.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cuma 16 Aralık 2005 00:04 tarihinde şunları yazmıştınız:
> Lee Revell wrote:
> >On Thu, 2005-12-15 at 14:46 -0700, Jeff V. Merkey wrote:
> >>Lee Revell wrote:
> >>>On Thu, 2005-12-15 at 14:07 -0700, Jeff V. Merkey wrote:
> >>>>When you are on the phone with an irrate customer at 2:00 am in the
> >>>>morning, and just turning off your broken 4K stack fix
> >>>>and getting the customer running matters.
> >>>
> >>>Bugzilla link please.  Otherwise STFU.
> >>
> >>??????
> >>
> >>Jeff
> >
> >You imply that your customer's problem was due to a kernel bug triggered
> >by CONFIG_4KSTACKS.  I am asking you to provide a link to the bug report
> >or get lost.
> >
> >Lee
>
> You hack on this code base (hack is the right word) -- I sell it,
> service and support it with customers in a dozen countries.  I don't report
> company level issues in "bugzilla" or anywhere else public unless they
> apply to kernel code.  calls from several of our apps (which use
> larger than 4K kernel space on a stack) from user space crash -- so do
> wireless drivers -- and kdb crashes as well with some bugs with 4K stacks
> turned on when you are trying to debug something.
>
> Hope that addresses your concerns "joe job".

You are supposed to report those bugs in a manner it won't conflict with the 
privacy of your customer(s). Linux distros do this already.

/ismail
