Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbTL3Qwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbTL3Qw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:52:29 -0500
Received: from holomorphy.com ([199.26.172.102]:43970 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265854AbTL3QwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:52:12 -0500
Date: Tue, 30 Dec 2003 08:52:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian Macy <bmacy@macykids.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 and Starfire NIC
Message-ID: <20031230165206.GO27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian Macy <bmacy@macykids.net>, linux-kernel@vger.kernel.org
References: <3FF1AC4D.9040002@macykids.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF1AC4D.9040002@macykids.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30, 2003 at 08:48:13AM -0800, Brian Macy wrote:
> When switching to 2.6.0 my Starfire NIC fails to function with an 
> entertaining message:
> Dec 23 16:36:45 job kernel: eth0: Something Wicked happened! 0x02018101.
> Dec 23 16:36:45 job kernel: eth0: Something Wicked happened! 0x02010001.
> I don't know if this is related but in 2.4 I get PCI bus congestion for 
> the starfire adapter:
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 80 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 96 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 112 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 128 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 144 bytes
> eth0: PCI bus congestion, increasing Tx FIFO threshold to 160 bytes

In 2.6, I get the message you got in 2.4.


-- wli
