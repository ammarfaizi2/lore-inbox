Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRCHWGT>; Thu, 8 Mar 2001 17:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbRCHWGJ>; Thu, 8 Mar 2001 17:06:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17935 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129733AbRCHWF7>; Thu, 8 Mar 2001 17:05:59 -0500
Subject: Re: Kernel stress testing coverage
To: plars@us.ibm.com (Paul Larson)
Date: Thu, 8 Mar 2001 22:08:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF50B88864.0721DA46-ON85256A09.006EE3FD@raleigh.ibm.com> from "Paul Larson" at Mar 08, 2001 02:57:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14b8ag-0003o3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. How much of the kernel is getting hit on a run of any given test?  Even
> an approximate percentage is fine as long as I can prove it.

I've not measured it by percentage. You could use the profiling code in
the kernel to generate a profile and from that measure coverage at least
for non interrupt blocking code

> piece of the kernel that they modified.  These type of things would be
> FYI this project will be going on sourceforge very soon.  I want to have a
> little more to start out with though and finish putting together a good
> project description, testplans, etc. to post as soon as we put it on there.
> I hate it when people start projects and you don't see any good information
> about it for weeks.

VA Cerberus has mahy of these

