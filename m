Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbTLIQWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbTLIQWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:22:47 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:4481 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S266129AbTLIQWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:22:46 -0500
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
In-Reply-To: <10N8i-7bE-1@gated-at.bofh.it>
References: <10vOq-7mK-11@gated-at.bofh.it> <10vON-7mK-29@gated-at.bofh.it> <10CGd-1SM-39@gated-at.bofh.it> <10DiJ-2Qj-17@gated-at.bofh.it> <10Kas-8kr-3@gated-at.bofh.it> <10Kka-dD-11@gated-at.bofh.it> <10LJg-3zb-9@gated-at.bofh.it> <10LT5-3Wo-13@gated-at.bofh.it> <10N8i-7bE-1@gated-at.bofh.it>
Date: Tue, 9 Dec 2003 17:22:36 +0100
Message-Id: <E1ATkdA-0000LB-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Dec 2003 11:20:06 +0100, you wrote in linux.kernel:

> # find /dev | wc -l
>     326

40k on ext2 (128 byte inodes). I'm betting devfs is more than 40k of code.
Plus devfs uses more memory than a filesystem-backed /dev, don't you think?

-- 
Ciao,
Pascal
