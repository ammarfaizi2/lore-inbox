Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWJQV5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWJQV5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWJQV5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:57:03 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:52659 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750848AbWJQV5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:57:00 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-rc1
Date: Wed, 18 Oct 2006 07:56:56 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <9bkaj29ku2dgbjl59heql5f625n90aii7m@4ax.com>
References: <20061017142926.GA3502@stusta.de>
In-Reply-To: <20061017142926.GA3502@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2006 16:29:26 +0200, Adrian Bunk <bunk@stusta.de> wrote:

>Security fixes since 2.6.16.29:
>- CVE-2006-3741: IA64: file descriptor reference counting in perfmon
>- CVE-2006-4623: DVB: Proper handling ULE SNDU length of 0
>- CVE-2006-4997: ATM CLIP: Do not refer freed skbuff in clip_mkip()
>
>
>Patch location:
>ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/linux-2.6.16.y/testing/

Test seven boxen okay here: <http://bugsplatter.mine.nu/test/linux-2.6/>

Cheers,
Grant.
