Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266594AbUAWQ72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 11:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUAWQ72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 11:59:28 -0500
Received: from ulysses.news.tiscali.de ([195.185.185.36]:24845 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S266594AbUAWQ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 11:59:16 -0500
To: linux-kernel@vger.kernel.org
Path: ulysses.tiscali.de!nobody
From: Peter Matthias <espi@epost.de>
Newsgroups: linux.kernel
Subject: Re: [PATCH] rivafb & small 16 bit mode problem
Date: Fri, 23 Jan 2004 16:05:41 +0100
Organization: Tiscali Germany
Message-ID: <58drub.99.ln@ulysses.tiscali.de>
References: <1gF6W-Np-7@gated-at.bofh.it> <1gNe0-84O-11@gated-at.bofh.it> <1h734-14p-9@gated-at.bofh.it>
NNTP-Posting-Host: p62.246.100.227.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1074877155 42425 62.246.100.227 (23 Jan 2004 16:59:15 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Fri, 23 Jan 2004 16:59:15 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Buescher schrieb:

> On Thu, 22 Jan 2004, [iso-8859-2] Pawe? Goleniowski wrote:
> 
>> But I have no idea which options should I send to kernel to get different
>> resolution (video=riva:800x600-16@85 don't work) and I have very ugly
Linux
>> logo while booting ;)
> 
> video=rivafb:800x600-16@85
>           ^^
> 
> should work

Well, even this does not work on my nforce 2 integrated grafics. Any clues?

Peter
