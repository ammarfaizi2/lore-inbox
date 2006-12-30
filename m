Return-Path: <linux-kernel-owner+w=401wt.eu-S1030283AbWL3GNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWL3GNq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 01:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbWL3GNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 01:13:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60745 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030283AbWL3GNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 01:13:45 -0500
Date: Fri, 29 Dec 2006 22:13:28 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: ebuddington@wesleyan.edu
Cc: Eric Buddington <ebuddington@verizon.net>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
Subject: Re: Oops in 2.6.19-rc6-mm2 on USB disconnect
Message-Id: <20061229221328.44c27757.zaitcev@redhat.com>
In-Reply-To: <20061230014556.GA16451@pool-70-109-253-37.wma.east.verizon.net>
References: <20061230014556.GA16451@pool-70-109-253-37.wma.east.verizon.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 20:45:57 -0500, Eric Buddington <ebuddington@verizon.net> wrote:

> Kernel 2.6.19-rc6-mm2 on an Athlon XP gave me the following Oops when
> unplugging a USB device. I an usually plug and unplug devices without
> trouble, so this is probably not easily repeatable.
> [1742510.173840] PREEMPT 

Yeah, naturally not easy. Thanks anyway... I think I'll take a look.

-- Pete
