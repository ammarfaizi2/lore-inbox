Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVBYMF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVBYMF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 07:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVBYMF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 07:05:57 -0500
Received: from bay14-f41.bay14.hotmail.com ([64.4.49.41]:35619 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262685AbVBYMEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 07:04:05 -0500
Message-ID: <BAY14-F4195FF14B317E75D3A8EAD95650@phx.gbl>
X-Originating-IP: [80.15.132.11]
X-Originating-Email: [tonyosborne_a@hotmail.com]
From: "tony osborne" <tonyosborne_a@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: tonyosborne_a@hotmail.com
Subject: why one stack per thread and one heap for all the threads?
Date: Fri, 25 Feb 2005 12:03:19 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 25 Feb 2005 12:04:01.0535 (UTC) FILETIME=[1806F0F0:01C51B32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wish to be personally CC'ed the answers/comments posted to the list in 
response to this post


why in multithreading, each thread has its own stack, but all share the same 
heap?
I understand that one stack is needed for each thread as each could have its 
own procedure call. but why we don't associate a heap for each thread since 
each thread can also create dynamically its own data?


Many thanks

_________________________________________________________________
It's fast, it's easy and it's free. Get MSN Messenger today! 
http://www.msn.co.uk/messenger

