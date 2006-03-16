Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932721AbWCPUfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbWCPUfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWCPUfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:35:32 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:58769 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932721AbWCPUfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:35:31 -0500
Date: Thu, 16 Mar 2006 21:35:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexander Gran <alex@zodiac.dnsalias.org>
cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Bug while trying to mount nfs share
In-Reply-To: <200603151244.34159@zodiac.zodiac.dnsalias.org>
Message-ID: <Pine.LNX.4.61.0603162133100.11776@yvahk01.tjqt.qr>
References: <200603151244.34159@zodiac.zodiac.dnsalias.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>just tried to mount a NFS share under 2.6.16-rc6-mm1. Didn't work out:
>Linux version 2.6.16-rc6-mm1 (root@t40) (gcc version 4.0.3 (Debian 4.0.3-1)) 
>#2 PREEMPT Tue Mar 14 09:49:56 CET 2006
>[...]
>127MB HIGHMEM available.
>896MB LOWMEM available.

BTW, you could try ot VMSPLIT_3G_OPT.



Jan Engelhardt
-- 
