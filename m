Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTGXLXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 07:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTGXLXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 07:23:18 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:31990 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262290AbTGXLXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 07:23:13 -0400
Subject: Re: Problems with IDE - Ultra-ATA devices on a SiI chipset IDE
	controler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: system_lists@nullzone.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.1.1.2.20030724011628.00bb6d38@192.168.2.130>
References: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
	 <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
	 <5.2.1.1.2.20030724011628.00bb6d38@192.168.2.130>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059046209.7993.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jul 2003 12:32:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-24 at 00:20, system_lists@nullzone.org wrote:
> Hello Alan,
> 
>     I am just using 2.4.21 kernel version (standard drivers of this kernel).
> 
> Let me know if could be useful to send more information or if you need that 
> I do some tests (let me know what you need and i will do).

Can you test 2.4.22pre7 as a starter. That would confirm its a bug in
the current IDE code still not a maybe fixed one

