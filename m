Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVJBAGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVJBAGb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 20:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVJBAGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 20:06:31 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:34253 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750917AbVJBAGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 20:06:31 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: =?ISO-8859-1?Q?=20Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Date: Sun, 02 Oct 2005 10:06:14 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <oh8uj15lvipg3bshv7j82j27j11l67ds49@4ax.com>
References: <20050927111038.GA22172@ime.usp.br> <1127863912.4802.52.camel@localhost> <20051001213655.GE6397@ime.usp.br>
In-Reply-To: <20051001213655.GE6397@ime.usp.br>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2005 18:36:55 -0300, Rogério Brito <rbrito@ime.usp.br> wrote:

>
>I have noticed the problem mostly on disk. One strange situation was
>when I was untarring a kernel tree (compressed with bzip2) and in the
>middle of the extraction, bzip2 complained that the thing was
>corrupted.
>
>I removed what was extracted right away and tried again to extract the
>tree (at this point, suspecting even that something in software had
>problems). The problem with bzip2 occurred again. Then, I rebooted the
>system an the problem magically went away.

This rings a bell, recently I reported a problem:
  http://www.uwsg.iu.edu/hypermail/linux/kernel/0508.1/1332.html

Turned out to be bad memory stick :o)

Cheers,
Grant.

