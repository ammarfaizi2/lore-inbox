Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266255AbUFRR1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266255AbUFRR1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUFRR1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:27:50 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:7572 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S266255AbUFRR1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 13:27:47 -0400
Subject: Re: Stop the Linux kernel madness
From: Ray Lee <ray-lk@madrabbit.org>
To: riel@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <2c0942db040618100264ea6b7d@mail.gmail.com>
References: <Pine.LNX.4.44.0406181037180.8065-100000@chimarrao.boston.redhat.com>
	 <2c0942db040618100264ea6b7d@mail.gmail.com>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1087579664.15659.108.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 10:27:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, this is a hint at certain embedded developers.  You
> know who you are and chances are you also know what you would
> like to develop if you no longer had to spend your time porting
> the same old patches from one version of the product to the next.

Speaking as someone who had to port 2.4.20 to a custom embedded
platform, starting from a fork of a fork (Wolfgang Denk's fork of
linuxppc-2.4-devel fork of mainline) was the quickest way to get to a
running board. (ie, the quickest way for me to get on to the next phase
of the software, which was all the driver code, and custom userspace
stuff for controlling everything).

At the end of the project, I looked at the patches, and tried to work
out what would be required to get the board running on mainline. It was
a lot of work. Which, I hasten to add, is a massive understatement.

Perhaps it has gotten better with 2.6. I don't know. But I'd hope that
those with the knowledge can eventually roll back in the needed changes
to mainline. It certainly would make this developer's life more
pleasant.

In the meantime, I'd like to thank the people behind the
linuxppc-2.4-devel tree, and Wolfgang, for making my life much easier
than it could have been.

Ray

