Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266409AbUGJUdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266409AbUGJUdL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUGJUdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:33:10 -0400
Received: from [195.205.111.101] ([195.205.111.101]:44595 "EHLO
	[195.205.111.101]") by vger.kernel.org with ESMTP id S266409AbUGJUcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:32:43 -0400
From: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm7
Date: Sat, 10 Jul 2004 22:32:39 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040708235025.5f8436b7.akpm@osdl.org> <200407102204.35889.mg@iceni.pl> <20040710132711.52ee2343.akpm@osdl.org>
In-Reply-To: <20040710132711.52ee2343.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407102232.39132.mg@iceni.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it repeatable at all?  If so, does using a different I/O scheduler fix
> it up?

Sorry, i've made a mistake, it's not cfq but an anticipatory scheduler :(
And no, I can't reproduce it (so far).

-- 
mg

