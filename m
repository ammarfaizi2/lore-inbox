Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbWGKD3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWGKD3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 23:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbWGKD3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 23:29:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29357
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965086AbWGKD3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 23:29:13 -0400
Date: Mon, 10 Jul 2006 20:29:56 -0700 (PDT)
Message-Id: <20060710.202956.83858417.davem@davemloft.net>
To: luke.adi@gmail.com
Cc: samuel@sortiz.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix an inproper alignment accessing in irda protocol
 stack
From: David Miller <davem@davemloft.net>
In-Reply-To: <489ecd0c0607101912t4225e551sa608faa769f09064@mail.gmail.com>
References: <489ecd0c0606131929l5311bdb9g1e903904f0d8fb2b@mail.gmail.com>
	<20060617.221435.48805608.davem@davemloft.net>
	<489ecd0c0607101912t4225e551sa608faa769f09064@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Luke Yang" <luke.adi@gmail.com>
Date: Tue, 11 Jul 2006 10:12:41 +0800

>   There is another same unaligend issue in irda stack to be fixed:
> 
> Signed-off-by: Luke Yang <luke.adi@gmail.com>

Your patch is corrupted by your email client and cannot be applied
cleanly to the current kernel sources.

This is the second time around I've had to ask you to correct this
kind of problem with your submissions.  Consider this my last and
final warning.

A lot of my time is wasted when patches are improperly submitted.
