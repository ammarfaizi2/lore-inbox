Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVI2TgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVI2TgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVI2TgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:36:05 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:54676 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964797AbVI2Tf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:35:56 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: jmerkey <jmerkey@utah-nac.org>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       Nuno Silva <nuno.silva@vgertech.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
Date: Fri, 30 Sep 2005 05:35:41 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <p8goj1h0a6g0oje8uijpi5r2b95l7sj8n4@4ax.com>
References: <Pine.LNX.4.63.0509290916450.20827@p34> <433C31C8.1030901@vgertech.com> <Pine.LNX.4.63.0509291433340.13272@p34> <433C2A11.9090506@utah-nac.org>
In-Reply-To: <433C2A11.9090506@utah-nac.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005 11:53:21 -0600, jmerkey <jmerkey@utah-nac.org> wrote:

>
>Someone needs to fix SATA drive ordering in the kernel so it matches 
>GRUBs ordering, or perhaps GRUB needs fixing. I have run into
                    ^^^^^^^^^^^^^^^^^^^^^^^^^
User-space issue?  Four of the last five drives I buy are SATA, I 
don't see this problem 'cos I use lilo :o)

Cheers
