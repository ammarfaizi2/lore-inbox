Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSDOWEz>; Mon, 15 Apr 2002 18:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313315AbSDOWEy>; Mon, 15 Apr 2002 18:04:54 -0400
Received: from f80.law9.hotmail.com ([64.4.9.80]:5641 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S313314AbSDOWEy>;
	Mon, 15 Apr 2002 18:04:54 -0400
X-Originating-IP: [139.95.254.33]
From: "Anupama Gujran" <anu_gujran@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: General Questions
Date: Mon, 15 Apr 2002 15:04:48 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F80FGwQ21ju2iDL6e5f00004163@hotmail.com>
X-OriginalArrivalTime: 15 Apr 2002 22:04:48.0506 (UTC) FILETIME=[8F31F5A0:01C1E4C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. In tcp_prequeue, why does the bh queue the packet in the prequeue and 
exits if ucopy.memory < socket's rcvbuf?
What is the relavence between the two?

2. TCP_CHECK_TIMER is a macro which is defined as follows

#define TCP_CHECK_TIMER(sk) do { } while (0);

What is the meaning of this statement? i.e., purpose of this dummy loop.

Your reply will be appreciated.

Thank you.
Anu



_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

