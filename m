Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbUCCD6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbUCCD6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:58:13 -0500
Received: from hera.kernel.org ([63.209.29.2]:22958 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262349AbUCCD5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:57:39 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: kernel mode console
Date: Wed, 3 Mar 2004 03:57:24 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c23l34$n46$1@terminus.zytor.com>
References: <200403022152.06950.billyrose@cox-internet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078286244 23687 63.209.29.3 (3 Mar 2004 03:57:24 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 3 Mar 2004 03:57:24 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200403022152.06950.billyrose@cox-internet.com>
By author:    Billy Rose <billyrose@cox-internet.com>
In newsgroup: linux.dev.kernel
>
> i have some bandwidth i can dedicate to writting a kernel module that provides 
> a command interpreter running in kernel space (think of it as the god mode 
> console in quake). the purpose for this would be primarily aimed at the 
> kernel developers so they can reach in and grab variables, dump certain 
> sections of memory, walk memory, dump code segments, dump processes 
> (including the kernel data structures for them), anything else i/you can 
> think of. is this a waste of time, or would that get used?
> 

Google(kgdb).

	-hpa
