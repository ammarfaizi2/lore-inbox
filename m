Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbUARX1d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 18:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUARX1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 18:27:33 -0500
Received: from tristate.vision.ee ([194.204.30.144]:2758 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S264289AbUARX1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 18:27:31 -0500
From: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar@city.ee>
Subject: Re: Unknown CPU
To: linux-kernel@vger.kernel.org
Date: Mon, 19 Jan 2004 01:27:30 +0200
References: <1eIsb-5BX-23@gated-at.bofh.it> <1eJob-6so-13@gated-at.bofh.it> <1eKX6-7RO-35@gated-at.bofh.it> <1eLT3-nm-19@gated-at.bofh.it>
User-Agent: KNode/0.7.6
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <20040118232730.8A27A1A0C@xs.dev>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:

> Nope, the CPU is clocked per spec.  I have an issue with this
> motherboard since I got it, half the time when I reboot it blurps and
> simply won't boot with a high-low warble.  I have to turn the machine
> off for about 30 minutes or drain the cmos and reset everything.
> 

I had this no-boot problem with one of the Epox mb's (nForce2). It just
hanged at POST and booted only after many tries. The solution was to
disable showing Health Information (those fan RPMs and temperatures) at
BIOS POST.

Strange, but works this way.

Maybe helps somebody.

Lenar
