Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbUK2VGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUK2VGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbUK2VGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:06:20 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:12955 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261804AbUK2VGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:06:16 -0500
Date: Mon, 29 Nov 2004 22:02:14 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Terry Griffin <terryg@axian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: odd behavior with r8169 and pcap
Message-ID: <20041129210213.GA3880@electric-eye.fr.zoreil.com>
References: <1101751909.2291.21.camel@tux.hq.axian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101751909.2291.21.camel@tux.hq.axian.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Griffin <terryg@axian.com> :
[...]
> So the obvious questions are: Is this a known problem? Why the
> heck does it do this? Is there a fix or workaround to get the
> high rate all the time other than running a pcap utility 24x7?

1 - not really
2 - details please:
    - which kernel versions have been tested ?
    - when did the bahavior appear first ?
    - which compiler version ?
    - can you provide a short description of the hardware ?
    - lspci -vx, lsmod, dmesg after boot, /proc/interrupts, vmstat 1
      for a few seconds when ok/nok will be welcome
3 - can it be reproduced with latest -bk ?

Please Cc: netdev@oss.sgi.com.

--
Ueimor
