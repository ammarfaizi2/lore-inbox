Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUEGUjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUEGUjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbUEGUiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:38:09 -0400
Received: from zero.aec.at ([193.170.194.10]:39950 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263740AbUEGUhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:37:46 -0400
To: Stephen Hemminger <shemminger@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Distributions vs kernel development
References: <1TfVQ-4T4-21@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 07 May 2004 20:42:10 +0200
In-Reply-To: <1TfVQ-4T4-21@gated-at.bofh.it> (Stephen Hemminger's message of
 "Fri, 07 May 2004 18:00:22 +0200")
Message-ID: <m38yg4hyf1.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> writes:

> After having being burned twice: first by Mandrake and supermount, and second
> by SuSe and reiserfs attributes; are any of the distributions committed to
> making sure that their distribution will run the standard kernel? (ie. 2.6.X from
> kernel.org). When running a non-vendor kernel, I need to reasonably expect that the system
> will boot and all the filesystems and standard devices are available.  I don't
> expect every startup script to run clean, or every device that has a driver
> only in the vendor kernel to work. 

The reiserfs attribute patch has been submitted many times,
but rejected for totally bogus reasons. You know who to complain to.

-Andi

