Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269030AbUJQDg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269030AbUJQDg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269032AbUJQDg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:36:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42450 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269030AbUJQDgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:36:20 -0400
Subject: Re: failure in /mm/memory.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: christophpfister@bluemail.ch,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041016120911.GW5607@holomorphy.com>
References: <412EB75E00164E05@mssazhh-int.msg.bluewin.ch>
	 <20041016120911.GW5607@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097980417.13428.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 17 Oct 2004 03:33:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-16 at 13:09, William Lee Irwin III wrote:
> On Sat, Oct 16, 2004 at 12:32:35PM +0100, christophpfister@bluemail.ch wrote:
> > i found a failure in function remap_pte_range in memory.c

I think the bug is in the comment not the code !

