Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTIZSnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbTIZSnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:43:21 -0400
Received: from xs.heimsnet.is ([193.4.194.50]:28068 "EHLO cg.c.is")
	by vger.kernel.org with ESMTP id S261580AbTIZSnU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:43:20 -0400
From: =?iso-8859-1?q?B=F6rkur=20Ingi=20J=F3nsson?= <bugsy@isl.is>
Reply-To: bugsy@isl.is
To: linux-kernel@vger.kernel.org
Subject: Re: khubd is a Succubus!
Date: Fri, 26 Sep 2003 18:55:43 +0000
User-Agent: KMail/1.5.3
References: <200309261724.56616.bugsy@isl.is> <200309261843.10099.bugsy@isl.is> <20030926183522.GB17690@kroah.com>
In-Reply-To: <20030926183522.GB17690@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309261855.43487.bugsy@isl.is>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 September 2003 18:35, you wrote:
> On Fri, Sep 26, 2003 at 06:43:10PM +0000, Börkur Ingi Jónsson wrote:
> > nvidia: no version magic, tainting kernel.
> > nvidia: module license 'NVIDIA' taints kernel.
> > 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed
> > Jul 16 19:03:09 PDT 2003
> > 0: NVRM: AGPGART: unable to retrieve symbol table
>
> Does this same problem happen without the nvidia driver loaded?


>
> > > > 2. I have a usb keyboard plugged in It's packard Bell model number
> > > > 9201
> > > >
> > > > 3. This did not happen with 2.4
> > > >
> > > > 4. ACPI is for laptops correct? I'm using a desktop and I've never
> > > > installed anything ACPI related..
> > >
> > > But is ACPI configured in your kernel?
> >
> > I checked the config and ACPI was configured.. Now compiling without
> > ACPI. Is that the reason? I think it was selected by default.
>
> I do not know, but if you do not need it, it should not be selected.
>
>
> greg k-h

how do I unload the nvidia driver?

