Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268148AbUH2AsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268148AbUH2AsT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 20:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUH2AsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 20:48:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21706 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268148AbUH2AsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 20:48:18 -0400
Subject: Re: 2.6.8.1 OOPS, processes hanging in D state, can reproduce
From: Lee Revell <rlrevell@joe-job.com>
To: Michael <quadfour@iinet.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0408290659030.3632-100000@natalie>
References: <Pine.LNX.4.50.0408290659030.3632-100000@natalie>
Content-Type: text/plain
Message-Id: <1093740497.7078.15.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 20:48:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 20:25, Michael wrote:
> First post to the list, never found a kernel bug before :)
> 

Your kernel is tainted, probably due to having a binary module loaded. 
Please reproduce with an untainted kernel and repost.

Lee

