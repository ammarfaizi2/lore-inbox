Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbTDUOOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 10:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDUOOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 10:14:16 -0400
Received: from coral.ocn.ne.jp ([211.6.83.180]:38086 "HELO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with SMTP id S261288AbTDUOOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 10:14:16 -0400
Date: Mon, 21 Apr 2003 23:26:16 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: mailing-lists@digitaleric.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 IDE Oops at boot
Message-Id: <20030421232616.5b48babb.bharada@coral.ocn.ne.jp>
In-Reply-To: <200304200251.31970.lkml@digitaleric.net>
References: <200304200251.31970.lkml@digitaleric.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003 02:51:31 -0400
Eric Northup <lkml@digitaleric.net> wrote:

> System is RedHat 9 running on an Athlon, Asus A7N8X motherboard - nForce2 
> chipset (with on-board Silicon Image SATA controller).  I also tried 
> 2.5.67-ac2, with the same result.  Modules are disabled, but preempt, ACPI, 
> and APIC are on (full .config appended at the end this message)

What happens if you try it with ACPI disabled?

