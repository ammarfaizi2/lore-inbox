Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVIWTSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVIWTSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVIWTSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:18:49 -0400
Received: from xenotime.net ([66.160.160.81]:38534 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751174AbVIWTSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:18:48 -0400
Date: Fri, 23 Sep 2005 12:18:47 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Abhay_Salunke@Dell.com
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: FW: [patch 2.6.14-rc2] dell_rbu: changes in packet update
 mechanism
In-Reply-To: <597A2BC19EDD3C458F841E8724E92D4B973E19@ausx3mps301.aus.amer.dell.com>
Message-ID: <Pine.LNX.4.58.0509231216110.20926@shark.he.net>
References: <597A2BC19EDD3C458F841E8724E92D4B973E19@ausx3mps301.aus.amer.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005 Abhay_Salunke@Dell.com wrote:

> Resending...for some reason the earlier email didn't go through.

probably because it's a very malformed patch (according to
'patch').

It's all line-wrapped in odd places.  Try again -- maybe
learn & copy what Matt does for email.

> @@ -35,6 +35,7 @@ The driver load creates the following di
>  /sys/class/firmware/dell_rbu/data
>  /sys/devices/platform/dell_rbu/image_type
>  /sys/devices/platform/dell_rbu/data
> +/sys/devices/platform/dell_rbu/packet_size
>
>  The driver supports two types of update mechanism; monolithic and
> packetized.
>  These update mechanism depends upon the BIOS currently running on the
> system.

For example, the patch meant to add one line above, but there
are actually 9 lines in that patch block (not 7).

-- 
~Randy
