Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269662AbUJMJ45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269662AbUJMJ45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 05:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbUJMJ45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 05:56:57 -0400
Received: from news.cistron.nl ([62.216.30.38]:37255 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S269662AbUJMJ4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 05:56:48 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: xfs problems in 2.6.9-rc4 ?
Date: Wed, 13 Oct 2004 09:56:45 +0000 (UTC)
Organization: Cistron Group
Message-ID: <ckiu4t$o0m$1@news.cistron.nl>
References: <ckit8i$np4$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1097661405 24598 62.216.29.200 (13 Oct 2004 09:56:45 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <ckit8i$np4$1@news.cistron.nl>,
Danny ter Haar <dth@ncc1701.cistron.net> wrote:
>On our usenet storage server (diablo setup) we are running
>2.6.9-rc4 and we see a *lot* of this in dmesg:
>
>xfs: possible memory allocation deadlock in kmem_alloc (mode:0xd0)
>xfs: possible memory allocation deadlock in kmem_alloc (mode:0xd0)
>printk: 2899 messages suppressed.

Yes. That's because we (at cistron) are running debug code on that
server, written by me. You're complaining to the wrong people, at least
right now :)

Mike.
-- 
"In times of universal deceit, telling the truth becomes
 a revolutionary act." -- George Orwell.

