Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTK2QyH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 11:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbTK2QyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 11:54:07 -0500
Received: from legolas.restena.lu ([158.64.1.34]:20904 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263824AbTK2QyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 11:54:04 -0500
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
From: Craig Bradney <cbradney@zip.com.au>
To: Julien Oster <frodoid@frodoid.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1070124422.28164.4.camel@athlonxp.bradney.info>
References: <200311292325.44935.csawtell@paradise.net.nz>
	 <1070104685.29442.24.camel@athlonxp.bradney.info>
	 <frodoid.frodo.87d6bbjfqa.fsf@usenet.frodoid.org>
	 <1070124422.28164.4.camel@athlonxp.bradney.info>
Content-Type: text/plain
Message-Id: <1070124842.28166.8.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 29 Nov 2003 17:54:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2003-11-29 at 17:47, Craig Bradney wrote:
> Hi Julien
> 
> > > I am also using a 2 week old A7N8X Deluxe, v2 with the latest 1007 BIOS.
> > > I AM able to run 2.6 Test 11 with APIC, Local APIC and ACPI support
> > > turned on (SMP off, Preemptible Kernel off).
> > 
> > Unfortunately, I have the exact same configuration, with massive
> > lockups. Could you try executing "hdparm -t /dev/<someharddisk>"
> > several times and see if it lockups?
> > 
> 
> I just ran it 20 times non stop, also compiling in the background..  +
> evolution, apache2, mysql, xchat, mozilla.. gkrellm.. etc No hassles.
> Uptime is now over 18 hours.
> 
> Spec is:
> a7n8x deluxe
> 2600+ 333mhz (not overclocked)
> 2x256ddr 400mhz running in dual ddr mode
> 80gb 8mb cache maxtor (hda) and a dvd rw (hdc) and cd rom (hdd)
> radeon 9000 pro
> 

I have the SATA controller disabled by jumper on the motherboard if that
could be one of the differences as I notice you are posting about SATA
too.

Craig

