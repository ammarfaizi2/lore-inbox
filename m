Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264266AbUGNUtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbUGNUtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUGNUtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:49:05 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:59025 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264266AbUGNUrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:47:04 -0400
Date: Wed, 14 Jul 2004 22:44:34 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Auzanneau Gregory <greg@reolight.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc1 and before: IO-APIC + DRI + RTL8139 = Disabling Ethernet IRQ
Message-ID: <20040714224434.A3414@electric-eye.fr.zoreil.com>
References: <40F4635C.3090003@reolight.net> <20040714013903.A21905@electric-eye.fr.zoreil.com> <40F4F8C1.6070900@reolight.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40F4F8C1.6070900@reolight.net>; from greg@reolight.net on Wed, Jul 14, 2004 at 11:11:29AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auzanneau Gregory <greg@reolight.net> :
[...]
> This seems change nothing. So, as you requested, I join my complete
> dmesg and lspci.

[...]

Two more questions:
- does the same kernel perform better if you append "acpi=off" on the
  kernel boot command line ?
- is there a known latest working 2.6.x kernel with acpi enabled for your
  hardware ?

(I assume you meant acpi instead of io-acpi in your former message ?)

--
Ueimor
