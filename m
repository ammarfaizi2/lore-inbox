Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265611AbUBGFrF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 00:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266642AbUBGFrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 00:47:05 -0500
Received: from cathy.bmts.com ([216.183.128.202]:62907 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S265611AbUBGFrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 00:47:03 -0500
Date: Sat, 7 Feb 2004 00:47:00 -0500
From: Mike Houston <mikeserv@bmts.com>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Message-Id: <20040207004700.0dd5e626.mikeserv@bmts.com>
In-Reply-To: <200402060006.32732.wnelsonjr@comcast.net>
References: <200402041820.39742.wnelsonjr@comcast.net>
	<20040205171028.652a694c.mikeserv@bmts.com>
	<20040206021522.12dfd362.mikeserv@bmts.com>
	<200402060006.32732.wnelsonjr@comcast.net>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004 00:06:32 -0800
Walt Nelson <wnelsonjr@comcast.net> wrote:

> I am not sure but patch-2.6.2-bk1.tar.gz has not produce the mouse problems. I 
> applied it about 14 hours ago. I have no seen any mouse problems. I noticed 
> that there was a possible fix for loosing ticks in it?
> 

Well, I've been running 2.6.2-bk2 for around 12 hours now, and the problem hasn't surfaced. While this is the longest I've gone, it still could be coincidence but I'm hoping that strange mouse glitch won't come back.

I'm going to move on to 2.6.3-rc1 now. Here's to having nothing to report :-)

Mike
