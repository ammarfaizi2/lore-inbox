Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267796AbUGWPg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267796AbUGWPg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUGWPg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:36:26 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:62166 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267796AbUGWPgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:36:25 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-I3
References: <20040722161941.GA23972@elte.hu>
	<20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
	<20040722175457.GA5855@ss1000.ms.mff.cuni.cz>
	<20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu>
	<20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu>
	<4d8e3fd30407230358141e0e58@mail.gmail.com>
	<20040723110430.GA3787@elte.hu>
	<4d8e3fd30407230442afe80c1@mail.gmail.com>
	<20040723120014.GA5573@elte.hu>
From: "Dang, Linh [CAR:2X23:EXCH]" <linh@linhdang.home>
Organization: Null
Date: Fri, 23 Jul 2004 11:36:22 -0400
In-Reply-To: <20040723120014.GA5573@elte.hu> (Ingo Molnar's message of "Fri,
 23 Jul 2004 14:00:14 +0200")
Message-ID: <wn5d62mybux.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
newbie questions:

1. is there a configuration for CONFIG_PREEMPT + softirq-defer ?

2. is there a need for softirq-lock-breaking with `CONFIG_PREEMPT +
   softirq-defer'? CONFIG_PREEMPT should be able to preempt ksoftirqd
   right?

Thanx
-- 
Linh Dang
