Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUECBpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUECBpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 21:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbUECBpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 21:45:07 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:27791 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263429AbUECBpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 21:45:05 -0400
Date: Sun, 2 May 2004 21:45:03 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Cc: "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: Dual Opteron 248s w/ 8GB RAM on Tyan K8W (S2885)
Message-ID: <20040503014503.GA2337@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <20040428225331.GA19698@aspsys.com> <200404300005.02814.vda@port.imtp.ilyichevsk.odessa.ua> <20040429211733.GD15563@aspsys.com> <20040430021516.GA18664@zero> <20040430050038.GA27617@aspsys.com> <Pine.LNX.4.53.0404300657420.3289@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0404300657420.3289@chaos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 07:01:38AM -0400, Richard B. Johnson wrote:
> It can't be. The only CPU(s) that would know anything about it and
> thus be able to use that RAM are running the operating system.

unless it's reserving it for cross-boot data. i remember there being some
error (ecc, machine checks?) logging option in the bios setup. *shrug* i
don't know much about x86(-64) bios. openboot and srm do save state, since
you can drop back to them without rebooting.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
