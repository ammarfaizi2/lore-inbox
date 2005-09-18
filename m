Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVIRU3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVIRU3h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 16:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVIRU3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 16:29:37 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:19635 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S932187AbVIRU3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 16:29:36 -0400
Message-ID: <432DCE2A.5070705@slaphack.com>
Date: Sun, 18 Sep 2005 15:29:30 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Macintosh/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       Hans Reiser <reiser@namesys.com>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
In-Reply-To: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> There are lots of reports of ReiserFS 3
> filesystems completely destroyed by minor hardware flakiness.

Honestly, this is one of the things I like about Linux.  If I have 
memory errors, Windows will just keep running, occasionally something 
will crash, you restart it, never suspecting just how corrupt things are 
getting under the hood.  On Linux, I generally get kernel panics pretty 
quickly, so I run memtest86 and replace the RAM.

If my hardware is flaky, I consider it my job to replace it, not the job 
of all my software to magically compensate for it.  If I lose data, oh 
well, I have backups.  If I didn't, I was asking for trouble anyway.
