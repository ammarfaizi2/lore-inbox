Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbTKJSwF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTKJSwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:52:05 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:17804 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264033AbTKJSwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:52:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 10:52:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andrea Arcangeli <andrea@suse.de>
cc: "H. Peter Anvin" <hpa@zytor.com>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <20031110183722.GE6834@x30.random>
Message-ID: <Pine.LNX.4.44.0311101050110.2097-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Andrea Arcangeli wrote:

> you must pick file2 before file1:
> 
> 	you:
> 
> 	do
> 		get file2
> 		get repo-file1-j
> 		get file1
> 	while file2 != file1 && sleep 10

Yes, this closes ;)



- Davide


