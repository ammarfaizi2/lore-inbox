Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUENS6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUENS6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 14:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUENS6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 14:58:50 -0400
Received: from holomorphy.com ([207.189.100.168]:26565 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262170AbUENS5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 14:57:06 -0400
Date: Fri, 14 May 2004 11:56:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jan Killius <jkillius@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq problem with nvidia driver
Message-ID: <20040514185653.GY1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jan Killius <jkillius@arcor.de>, linux-kernel@vger.kernel.org
References: <200405142046.04276.jkillius@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405142046.04276.jkillius@arcor.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 08:46:04PM +0200, Jan Killius wrote:
> Hello,
> there is some irq problem with the nvidia kernel module. After running the 
> xserver for a while it freezes:
> Badness in pci_find_subsys at drivers/pci/search.c:167
> Call Trace:<IRQ> <ffffffff801fb773>{pci_find_subsys+83} 
> <ffffffff801fb862>{pci_find_slot+50}
>        <ffffffffa0025da0>{:nvidia:os_pci_init_handle+32} 

Please send the bugreport to nvidia.com


-- wli
