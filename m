Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVJPLvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVJPLvk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 07:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVJPLvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 07:51:40 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:20882 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S1751187AbVJPLvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 07:51:39 -0400
Date: Sun, 16 Oct 2005 13:51:39 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: uinput crash and NO FIX YET
Message-ID: <20051016115139.GB2084@tink>
References: <20051015212911.GA25752@tink> <20051015225157.GA7146@tink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20051015225157.GA7146@tink>
User-Agent: Mutt/1.5.9i
From: emard@softhome.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI

I tested uinput that crashes on my SMP PREEMPT 2.6.13.4 (pentium 4 HT)
on a 1-CPU 2.6.12.5 (pentium 3) and there is no such crash.

Something evil is happening with uinput on SMP machines

