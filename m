Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTAUF7o>; Tue, 21 Jan 2003 00:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbTAUF7o>; Tue, 21 Jan 2003 00:59:44 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:6784 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S262871AbTAUF7o>; Tue, 21 Jan 2003 00:59:44 -0500
Subject: Re: anyone have a 16-bit x86 early_printk?
From: Alan <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030114113036.GG940@holomorphy.com>
References: <20030114113036.GG940@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043116327.13142.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 21 Jan 2003 02:32:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-14 at 11:30, William Lee Irwin III wrote:
> I'm trying to get a box to boot and it appears to drop dead before
> start_kernel(). Would anyone happen to have an early_printk() analogue
> for 16-bit x86 code?

Linux 8086 has a complete mini-linux for it, let alone printk. A bcc
compileable printk is included

