Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUFFX5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUFFX5g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 19:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264244AbUFFX5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 19:57:36 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:64901 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264238AbUFFX5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 19:57:35 -0400
Date: Mon, 7 Jun 2004 01:57:31 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux crashing on amd athlons?
Message-ID: <20040606235730.GA10458@merlin.emma.line.org>
Mail-Followup-To: linux kernel <linux-kernel@vger.kernel.org>
References: <001701c44bf7$c8991f20$0200a8c0@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001701c44bf7$c8991f20$0200a8c0@laptop>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jun 2004, Ameer Armaly wrote:

> While installing linux on an amd athlon, the kernel is oopsing and shuting
> down the computer at random places  within the install.  This is a custom
> built kernel off of kernel.org I built, which I optimized for athlon then
> i386 afterwards, but with no luck.

I have several Athlons (from the venerable 500 to the new XP 2600+) in
use at various sites, no problems. Among them an XP 1700+ in server use
with vanilla 2.4.26, rock solid.

Check you've used a supported compiler and binutils, then check the
hardware. Cooling (heat sink), RAM (try memtest86), power supply, proper
clock speed and core voltage, proper RAM timing -- these are all
contributing factors to instability if not carefully chosen and
installed.

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95
