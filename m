Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTAYA4B>; Fri, 24 Jan 2003 19:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbTAYA4B>; Fri, 24 Jan 2003 19:56:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:23186 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265998AbTAYA4A>; Fri, 24 Jan 2003 19:56:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 24 Jan 2003 17:10:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Janet Morgan <janetmor@us.ibm.com>
cc: Hui_Ning@3com.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll patch for 2.4.18
In-Reply-To: <3E31D349.9B8CF412@us.ibm.com>
Message-ID: <Pine.LNX.4.50.0301241709260.2858-100000@blue1.dev.mcafeelabs.com>
References: <OFBBFE5834.6A43553D-ON86256CB8.0078A5B3@3com.com>
 <3E31D349.9B8CF412@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, Janet Morgan wrote:

> sys_epoll 2.5.51 (which I believe is still current) was backported to 2.4.20 in
> the following patch and should provide the support you're looking for:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104009079418105&w=2
> Note it won't apply cleanly to 2.4.18, but should be easy to rework.

Janet, I'll have to change a few bits in eventpoll.c this weekend. I will
repost the 2.4.x patch inside the epoll page @xmailserver.org



- Davide

