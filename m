Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317552AbSFRTKr>; Tue, 18 Jun 2002 15:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317556AbSFRTKq>; Tue, 18 Jun 2002 15:10:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14977 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317552AbSFRTKp>; Tue, 18 Jun 2002 15:10:45 -0400
Date: Tue, 18 Jun 2002 15:13:24 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Myrddin Ambrosius <imipak@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Drivers, Hardware, and their relationship to Bagels.
In-Reply-To: <20020618183515.13963.qmail@web12302.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020618150139.8402A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Myrddin Ambrosius wrote:


> 
> I guess that my understanding for having kernels the
> size and complexity of Linux, as opposed to, say,
> CP/M, is that the kernel can reduce the need for
> userspace apps to have dangerous powers.

Users need to have 'dangerous' things done, like reading and
writing to hard-disks, etc. To keep things organized, like
writing and reading files they control, there is some code
called the kernel, that performs these 'dangerous' things on
behalf of the callers. Since the callers can't modify the kernel
to make it do "bad" things like writing outside "files",  everything
works out just fine. The exact same things can usually be done by
"user-mode" programs. You just need to keep them from being hacked and
everything works out just fine, just like in the kernel.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

