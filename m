Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSGQQKj>; Wed, 17 Jul 2002 12:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSGQQKj>; Wed, 17 Jul 2002 12:10:39 -0400
Received: from dsl-65-185-37-21.telocity.com ([65.185.37.21]:1502 "EHLO
	onevista.com") by vger.kernel.org with ESMTP id <S315279AbSGQQKi>;
	Wed, 17 Jul 2002 12:10:38 -0400
Reply-To: johna@onevista.com
Message-Id: <200207171613.MAA24112@onevista.com>
Content-Type: text/plain; charset=US-ASCII
From: John Adams <johna@onevista.com>
Organization: One Vista Associates
To: linux-kernel-owner+johna=40onevista.com@vger.kernel.org,
       Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.19-rc1-ac7
Date: Wed, 17 Jul 2002 12:13:31 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200207171056.g6HAuXR24678@devserv.devel.redhat.com> <1026920340.11636.63.camel@spc9.esa.lanl.gov>
In-Reply-To: <1026920340.11636.63.camel@spc9.esa.lanl.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 11:39 am, Steven Cole wrote:
> On Wed, 2002-07-17 at 04:56, Alan Cox wrote:
> > Linux 2.4.19rc1-ac7
> >
> > o	Hopefully fix the SMP APIC problems rc6		(James Cleverdon)
> > 	gave some people
>
> Not yet fixed for me. Here is the error shortly after the very beginning
> of the boot:
>
> APIC error on CPU0: 08(08)
> APIC error on CPU0: 08(08)
> message repeats at this point.

> CONFIG_SMP=y for this kernel.
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y

I have the same problems with an ABIT VP6
rc1-ac5 works, ac6 & ac7 fail to boot.


johna
