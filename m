Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbVJ1VXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbVJ1VXl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbVJ1VXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:23:41 -0400
Received: from ns.suse.de ([195.135.220.2]:29085 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751768AbVJ1VXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:23:40 -0400
From: Andi Kleen <ak@suse.de>
To: Yinghai Lu <yinghai.lu@amd.com>
Subject: Re: x86_64: calibrate_delay_direct and apic id lift for BSP
Date: Fri, 28 Oct 2005 23:24:33 +0200
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linuxbios@openbios.org
References: <6F7DA19D05F3CF40B890C7CA2DB13A4201E061EC@ssvlexmb2.amd.com> <86802c440510281319y667427fj38ffd7a37b8cb77b@mail.gmail.com>
In-Reply-To: <86802c440510281319y667427fj38ffd7a37b8cb77b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510282324.34337.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 22:19, Yinghai Lu wrote:
> I wonder if 8111 only support 4 bit apicid, so it can not send irq to
> BSP at apic id 0x10....


Well, you being at AMD are probably in a much better position to find
out than most other folks. Or try the datasheet from the website.

-Andi
