Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291771AbSBTLaE>; Wed, 20 Feb 2002 06:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSBTL35>; Wed, 20 Feb 2002 06:29:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60688 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291771AbSBTL3p>;
	Wed, 20 Feb 2002 06:29:45 -0500
Message-ID: <3C7388A1.D5778A96@mandrakesoft.com>
Date: Wed, 20 Feb 2002 06:29:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joakim =?iso-8859-1?Q?B=E4cklund?= <jeck@Jeck.To>
CC: linux-kernel@vger.kernel.org
Subject: Re: Something is wrong.
In-Reply-To: <Pine.LNX.4.20.0202201206230.11398-100000@burken.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joakim Bäcklund wrote:
> 
> Hello.
> 
> In the recent kernel 2.4 I can't find the module rtl8139.o.
> And I chose <M> on the realtek part in menuconfig.
> I need that driver for my networkcard that is a little old and there
> isn't any other drives for it I think.
> In 2.2.* it could be found but not in 2.4.* so maybe you've change name on
> that module or sth?

yep, "rtl8139" was removed from the kernel.

"8139too" driver is what you want.

-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
