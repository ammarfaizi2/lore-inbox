Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289749AbSBJU4v>; Sun, 10 Feb 2002 15:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289750AbSBJU4l>; Sun, 10 Feb 2002 15:56:41 -0500
Received: from [216.163.188.200] ([216.163.188.200]:16147 "EHLO
	C9Mailgw06.amadis.com") by vger.kernel.org with ESMTP
	id <S289749AbSBJU4h>; Sun, 10 Feb 2002 15:56:37 -0500
Message-ID: <3C66DE64.B2C6036D@starband.net>
Date: Sun, 10 Feb 2002 15:56:04 -0500
From: Justin Piszcz <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How do I get "make install" to handle GRUB?
In-Reply-To: <1013371603.29598.4.camel@turbulence.megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ik - http://www.installkernel.com/ handles grub installations.

Miles Lane wrote:

> I have GRUB installed with RH 7.2.  I build and test
> the development kernel series.  How can I get "make install"
> to work with GRUB?  It seems like maybe we need a "install-grub"
> target or we need to have a way to automatically determine the
> bootloader being used and then do corresponding install method.
>
>         Miles
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

