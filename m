Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWAOVMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWAOVMY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWAOVMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:12:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64422 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750886AbWAOVMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:12:24 -0500
Date: Sun, 15 Jan 2006 22:12:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jiri Slaby <xslaby@fi.muni.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: Re: spurious 8259A interrupt: IRQ7
In-Reply-To: <20060115172118.A9CE622B38F@anxur.fi.muni.cz>
Message-ID: <Pine.LNX.4.61.0601152211150.29696@yvahk01.tjqt.qr>
References: <20060115172118.A9CE622B38F@anxur.fi.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Cc: benh@kernel.crashing.org
>
>>Hello,
>>
>>  0:     367164          XT-PIC  timer

>>01:05.0 VGA compatible controller: ATI Technologies Inc RS300M AGP [Radeon Mobility 9100IGP] (prog-if 00 [VGA])
>>        Subsystem: ASUSTeK Computer Inc.: Unknown device 1902

You seem to have APIC disabled?



Jan Engelhardt
-- 
