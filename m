Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129297AbRBTS76>; Tue, 20 Feb 2001 13:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130145AbRBTS7t>; Tue, 20 Feb 2001 13:59:49 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:58707 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S129297AbRBTS7e>; Tue, 20 Feb 2001 13:59:34 -0500
Date: Tue, 20 Feb 2001 19:58:10 +0100 (CET)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: michaelc <michaelc@turbolinux.com.cn>
cc: <linux-kernel@vger.kernel.org>, <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: about acpi problems
In-Reply-To: <1517849203.20010220113059@turbolinux.com.cn>
Message-Id: <Pine.LNX.4.31.0102201956140.5240-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, michaelc wrote:

>         I found that acpi driver has some bugs, I compiled the 2.4.2-pre4
>   kernel with the acpi support option and SMP enabled, it caused hang at the
>   boot time, but when I disabled the SMP option, it 's OK , so I look
>   into the acpi driver source code, and I found the acpi idle function
>   don't support the SMP, is that cause the kernel hang at boot time.

Could you submit a full bug report, as per the ACPI HOWTO
(http://www.columbia.edu/~ariel/acpi/acpi_howto.txt)?

Thanks,
   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

