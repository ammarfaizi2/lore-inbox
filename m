Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286433AbRLTWou>; Thu, 20 Dec 2001 17:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286438AbRLTWol>; Thu, 20 Dec 2001 17:44:41 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:36100 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286433AbRLTWo3>; Thu, 20 Dec 2001 17:44:29 -0500
Date: Thu, 20 Dec 2001 14:47:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alex <akhripin@mit.edu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Slight optimizations to entry.S patch
In-Reply-To: <20011220223221.GA17913@morgoth.mit.edu>
Message-ID: <Pine.LNX.4.40.0112201443480.1622-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, Alex wrote:

> Hi,
> I was familiarizing (or trying to) myself with the i386 architecture code,
> and saw a few possible optimizations. I think they can save a few cycles (not
> that many). Can someone comment? Are the changes worthwhile?

The first page of your x86 book starts talking about read-after-write
pipeline stall ? Damn what a book :)




- Davide



