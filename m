Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbTKMUtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 15:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTKMUtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 15:49:20 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:34452 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S264412AbTKMUtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 15:49:20 -0500
Date: Thu, 13 Nov 2003 21:49:09 +0100
From: Roger Luethi <rl@hellgate.ch>
To: xkernel@o2.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with DFE-530TX
Message-ID: <20031113204909.GA5074@k3.hellgate.ch>
Mail-Followup-To: xkernel@o2.pl, linux-kernel@vger.kernel.org
References: <20031113180649.5D48DD0BCC@rekin.go2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031113180649.5D48DD0BCC@rekin.go2.pl>
X-Operating-System: Linux 2.6.0-test9 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003 19:06:49 +0100, xkernel@o2.pl wrote:
> I have a problem with VIA-RHINE driver using two D-LINK DFE-530TX cards.
> Problem occurs when I'v got compiled in kernel driver with enabled option
> "use MMIO". Kernel recognizes both cards assigns eth0, eth1 but when I
> try to set IP on eth1 it errors with message "device or resource busy".

Does the MMIO setting matter? Also, does disabling APIC and ACPI help?

Roger
