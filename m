Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTEXTCY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 15:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTEXTCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 15:02:24 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:5505
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263398AbTEXTCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 15:02:23 -0400
Date: Sat, 24 May 2003 15:05:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: =?ISO-8859-2?Q?Rafa=5E=283=29_=27rmrmg=27_Roszak?= <rmrmg@wp.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [isdn] avm fritz pci
In-Reply-To: <3ECFBD82.60503@gmx.net>
Message-ID: <Pine.LNX.4.50.0305241504100.2267-100000@montezuma.mastecende.com>
References: <20030519134546.4c4395bf.rmrmg@wp.pl> <20030524082545.2d1cbdc2.rmrmg@wp.pl>
 <3ECF8559.5050209@gmx.net> <20030524193144.34dcd6b4.rmrmg@wp.pl>
 <3ECFBD82.60503@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003, Carl-Daniel Hailfinger wrote:

> It will be compiled in automatically if you select
> "Local APIC Support on Uniprocessors" and "IO-APIC support on
> uniprocessors", then boot with
> nmi_watchdog=1

He'd have more luck with nmi_watchdog=2 on UP (not a lot of UP 
motherboards have IOAPICs)

	Zwane
-- 
function.linuxpower.ca
