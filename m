Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUHBN1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUHBN1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266514AbUHBN1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:27:13 -0400
Received: from zero.aec.at ([193.170.194.10]:60172 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266517AbUHBN1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:27:07 -0400
To: Peter Williams <pwil3058@bigpond.net.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler
 Evaluation
References: <2oEEn-197-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 02 Aug 2004 15:27:03 +0200
In-Reply-To: <2oEEn-197-9@gated-at.bofh.it> (Peter Williams's message of
 "Mon, 02 Aug 2004 08:40:07 +0200")
Message-ID: <m3isc1smag.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> writes:

> Version 3 of the various single priority array scheduler patches for
> 2.6.7, 2.6.8-rc2 and 2.6.8-rc2-mm1 kernels are now available for
> download and evaluation:

[...] So many schedulers. It is hard to chose one for testing.

Do you have one you prefer and would like to be tested especially? 

Perhaps a few standard benchmark numbers for the different ones 
(e.g. volanomark or hackbench or the OSDL SDL tests) would make it 
easier to preselect.

Have you considered submitting one to -mm* for wider testing?

-Andi 

