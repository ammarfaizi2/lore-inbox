Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132932AbRDRAWo>; Tue, 17 Apr 2001 20:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132933AbRDRAWe>; Tue, 17 Apr 2001 20:22:34 -0400
Received: from dsl-64-128-37-73.telocity.com ([64.128.37.73]:58893 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S132932AbRDRAWY>; Tue, 17 Apr 2001 20:22:24 -0400
Message-Id: <4.3.2.7.2.20010417200027.00d31b70@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 17 Apr 2001 20:01:57 -0400
To: Subba Rao <subba9@home.com>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Adaptec 2940 and Linux 2.2.19
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010417194558.A10678@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subba,

The 2940 uses an AIC7890 (or related) chip.  Look for AIC7XXX in the options.

David

At 03:45 PM 4/17/01, Subba Rao wrote:

>Hi,
>
>The kernel configuration menu items have been changing quite a bit. So, I
>apologize for asking a trivial question in this forum.
>
>I am trying to configure and install linux kernel 2.2.19. This system has
>a Adaptec 2940 SCSI adapter. I have enabled SCSI support kernel configuration
>menu and also have selected all the Adaptec low-level drivers. They include
>(actually what is offered), AHA152X/2825, AHA1542 and AHA1740. When the kernel
>is booting up it still does not find the AHA2940 adapter.
>
>What (other) options should I configure to make Linux 2.2.19 find the adapter?
>
>Thank you in advance for any help.
>--
>
>Subba Rao
>subba9@home.com
>http://members.home.net/subba9/
>
>GPG public key ID 27FC9217
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       Ann Arbor, MI 48103
www.osagesoftware.com          tel:  734.821.8800

