Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268176AbUIWRWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268176AbUIWRWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268172AbUIWRVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:21:39 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:14758 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268189AbUIWRUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:20:41 -0400
Date: Thu, 23 Sep 2004 18:21:30 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: linux-kernel@vger.kernel.org
Cc: discuss@x86-64.org
Subject: 2.6.8.1 doesn't boot on x86_64
Message-ID: <Pine.LNX.4.44.0409231814500.2275-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I haven't heard about it on x86_64 discuss list so I thought it is worth 
asking if someone else has encountered this. When I boot 2.6.8.1 kernel 
(patched with kdb) the last thing I see is:

Freeing unused kernel memory: 160k f

I don't get the whole word "freed", only the first letter "f". This is SMP 
kernel. I will try recompiling without kdb and also booting as "nosmp" to 
see if it makes any difference.

Fedora Core 2 smp kernel boots fine, btw.

Kind regards
Tigran


