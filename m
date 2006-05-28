Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWE1RyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWE1RyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWE1RyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:54:15 -0400
Received: from pih-relay06.plus.net ([212.159.14.133]:22214 "EHLO
	pih-relay06.plus.net") by vger.kernel.org with ESMTP
	id S1750833AbWE1RyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:54:14 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Marc Perkel <marc@perkel.com>
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
Date: Sun, 28 May 2006 18:54:08 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <44793100.50707@perkel.com>
In-Reply-To: <44793100.50707@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605281854.08371.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 06:11, Marc Perkel wrote:
> Is there a problem with the forcedeth driver not being compatible with
> the Asus K8N-VM motherboard? I installed Fedora Core 5 and the Ethernet
> doesn't want to work. I installed the latest FC5 kernel which is some
> flavor og 2.6.16 and it still doesn't work. The FC4 CD and rescue disk
> don't work either. Windows XP however does work so I know that hardware
> is good.
>
> lspci says the hardware is an nVidia MCP51 ethernet controller. What am
> I missing?

A decent bug report. Please go to http://bugzilla.kernel.org/ and publish your 
lspci, /proc/interrupts and dmesg and if you're sure it's forcedeth, put the 
maintainer on CC.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
