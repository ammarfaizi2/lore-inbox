Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbTCPU2h>; Sun, 16 Mar 2003 15:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbTCPU2h>; Sun, 16 Mar 2003 15:28:37 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6404 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262741AbTCPU2g>;
	Sun, 16 Mar 2003 15:28:36 -0500
Date: Sun, 16 Mar 2003 21:36:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: LKML <linux-kernel@vger.kernel.org>
Cc: andi@lisas.de
Subject: Re: [Bug 464] New: 2.5.64: Dell Inspiron 8000 BIOS A04 EMERGENCY SHUTDOWN!
Message-ID: <20030316203629.GA13006@elf.ucw.cz>
References: <57820000.1047827557@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57820000.1047827557@[10.10.2.4]>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Steps to reproduce:
> I don't want to describe that here, since I really don't intend to put my
> machine through yet another emergency shutdown...
> You need to produce some high CPU load, though...

Heh, show us /proc/acpi/thermal/*.

Also don't fear emergency shutdowns -- they do NOT damage
hardware. [This machine survived >20 of them.]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
