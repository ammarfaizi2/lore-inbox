Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbUCZFZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263947AbUCZFZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:25:37 -0500
Received: from zero.aec.at ([193.170.194.10]:36360 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263150AbUCZFZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:25:33 -0500
To: John Lee <johnl@aurema.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O(1) Entitlement Based Scheduler v1.1
References: <1DQZ8-3XZ-5@gated-at.bofh.it> <1DRLx-4Ag-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 26 Mar 2004 02:26:12 +0100
In-Reply-To: <1DRLx-4Ag-7@gated-at.bofh.it> (John Lee's message of "Fri, 26
 Mar 2004 06:10:07 +0100")
Message-ID: <m3brmkbdqj.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Lee <johnl@aurema.com> writes:
>
> On the contrary, any reports of strange/bad behaviour are useful. It 
> probably is related to the scheduler, as no one seems to have reported 
> this problem with stock 2.6.4.

Actually I saw it on 2.6.5rc2 with your scheduler patch merged
(and my x86-64 patchkit, but that is unlikely to affect scheduling
decisions). 

-Andi

