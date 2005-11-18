Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVKRPTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVKRPTB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKRPTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:19:01 -0500
Received: from mx1.cdacindia.com ([203.199.132.35]:16989 "HELO
	mx2.cdac.ernet.in") by vger.kernel.org with SMTP id S1750796AbVKRPTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:19:00 -0500
Message-ID: <437DEF2A.5030609@cdac.in>
Date: Fri, 18 Nov 2005 20:41:38 +0530
From: Karthik Sarangan <karthiks@cdac.in>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sem_t
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is the 'struct _pthread_fastlock' a spin-lock? which primitive will 
implement non-cpu intensive synchronization?

my kernel is 2.6.9 (Distro RHEL WS 4 Update 1)

Karthik S

