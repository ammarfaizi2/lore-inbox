Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTKYRHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbTKYRHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:07:51 -0500
Received: from mail1-106.ewetel.de ([212.6.122.106]:31934 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S261598AbTKYRHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:07:50 -0500
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc5
In-Reply-To: <VOyg.w9.11@gated-at.bofh.it>
References: <VOyg.w9.13@gated-at.bofh.it> <VOyg.w9.11@gated-at.bofh.it>
Date: Tue, 25 Nov 2003 18:07:45 +0100
Message-Id: <E1AOgfB-0000OY-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003 17:50:20 +0100, you wrote in linux.kernel:

>    "overcommit_memory < 0" supposed to not allow apps to overallocate 
> memory - but still it works not like it is said in 
> Documentation/filesystems/proc.txt.

That file mentiones setting overcommit_memory to 0 to disable overcommit.
Have you tried that?

-- 
Ciao,
Pascal
