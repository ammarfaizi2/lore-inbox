Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270516AbTGaWwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270583AbTGaWwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:52:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:62168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270516AbTGaWwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:52:10 -0400
Date: Thu, 31 Jul 2003 15:40:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: Panic on 2.6.0-test1-mm1
Message-Id: <20030731154020.61e15723.akpm@osdl.org>
In-Reply-To: <20030731224148.GJ15452@holomorphy.com>
References: <5110000.1059489420@[10.10.2.4]>
	<20030731223710.GI15452@holomorphy.com>
	<20030731224148.GJ15452@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> You may now put the "aggravated" magnet beneath the "wli" position on
> the fridge.

I never, ever, at any stage was told that highpmd.patch offered any
benefits wrt lock contention or node locality.  I was only told that it
saved a little bit of memory on highmem boxes.

It would be useful to actually tell me what your patches do.  And to
provide test results which demonstrate the magnitude of the performance
benefits.

