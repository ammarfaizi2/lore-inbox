Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbVKPMPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbVKPMPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVKPMPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:15:19 -0500
Received: from science.horizon.com ([192.35.100.1]:42555 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030297AbVKPMPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:15:19 -0500
Date: 16 Nov 2005 07:15:12 -0500
Message-ID: <20051116121512.22803.qmail@science.horizon.com>
From: linux@horizon.com
To: jwboyer@gmail.com
Subject: Re: [RFC] HOWTO do Linux kernel development
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What should you not do?
> 
> - expect your patch to be accepted without question
> - become defensive
> - ignore comments and resubmit the patch without making any changes
> - explain how your project is funded by XYZ and therefore must be
>   awesome as it is
> 
> In a community that is looking for the best technical solution
> possible, there will always be differing opinions on how beneficial a
> patch is.  You have to be cooperative, and
> willing to adapt your idea to fit within the kernel.  Or at least be
> willing to prove your idea is worth it.  Remember, being wrong is ok
> as long as you are willing to work toward a solution that is right.

One thing to add is that you do NOT have to be a crowd-pleasing politican
and make every change that some random person on lkml suggests.

Indeed, because you're getting comments from a large group of individuals
and not a single entity, you may get flat-out contradictory feedback.

Obviously, comments from the maintainers of subsystems you're touching
should be accorded significant weight, but you can disagree with Linus
if you have a good enough reason.  What you should do is think about the
comments and, if you disagree, explain why your way is better.
