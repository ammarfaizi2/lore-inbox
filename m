Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbUAEAt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 19:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUAEAt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 19:49:28 -0500
Received: from hermes.domdv.de ([193.102.202.1]:14605 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id S265831AbUAEAt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 19:49:27 -0500
Message-ID: <3FF8B35E.1050704@domdv.de>
Date: Mon, 05 Jan 2004 01:44:14 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: tomwallard@soon.com, linux-kernel@vger.kernel.org
Subject: Re: Any hope for HPT372/HPT374 IDE controller?
References: <Pine.LNX.4.10.10401041431520.31033-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10401041431520.31033-100000@master.linux-ide.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Some of the problems appear with the APIC routing and interrupts being
> lost and not begin processed.
> 

Hopefully this will solve problems for X86-64 AMD chipset based MoBos 
too. I can run my Tyan S2885 only with IO-APIC disabled due to HPT302 
lockups (2.4)/lost interrupts (2.6).
-- 
Andreas Steinmetz

