Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSAFO6q>; Sun, 6 Jan 2002 09:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288966AbSAFO6g>; Sun, 6 Jan 2002 09:58:36 -0500
Received: from port-213-20-228-212.reverse.qdsl-home.de ([213.20.228.212]:16649
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S288965AbSAFO6R> convert rfc822-to-8bit; Sun, 6 Jan 2002 09:58:17 -0500
Date: Sun, 06 Jan 2002 15:58:01 +0100 (CET)
Message-Id: <20020106.155801.28805054.rene.rebe@gmx.net>
To: shaffei@softhome.net
Cc: linux_egypt@yahoogroups.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.17 and the ACPI support
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <1010327335.1415.39.camel@test.eth>
In-Reply-To: <1010327335.1415.39.camel@test.eth>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

From: Ibrahim El-Shafei <shaffei@softhome.net>
Subject: Kernel 2.4.17 and the ACPI support
Date: 06 Jan 2002 16:28:51 +0200

> Dear all,
> My machine is i686 with 128 RAM, 1GHz processor, and the motherboard
> supports ACPI.
> 
> When I press the power button the computer goes in sleep mode.
>
> I compiled the kernel 2.4.17 with ACPI support but when I press the
> power button to make the computer go in sleep mode it doesn't do
> anything, why?

Because ACPI sleep is work in progress. To power your box down, you
need the acpid from http://acpid.sourceforge.net/

There are very eperimental patches for suspend out - but I would not
recommend to use them.

> thank you for your help.
> 
> Yours,
> Ibrahim El-Shafei
> "HimaTech"
> 
> Imagination is better than knowledge
> 	--Albert Einstein

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
