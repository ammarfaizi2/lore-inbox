Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTK2QrI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 11:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTK2QrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 11:47:08 -0500
Received: from legolas.restena.lu ([158.64.1.34]:48550 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263788AbTK2QrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 11:47:05 -0500
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
From: Craig Bradney <cbradney@zip.com.au>
To: Julien Oster <frodoid@frodoid.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <frodoid.frodo.87d6bbjfqa.fsf@usenet.frodoid.org>
References: <200311292325.44935.csawtell@paradise.net.nz>
	 <1070104685.29442.24.camel@athlonxp.bradney.info>
	 <frodoid.frodo.87d6bbjfqa.fsf@usenet.frodoid.org>
Content-Type: text/plain
Message-Id: <1070124422.28164.4.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 29 Nov 2003 17:47:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien

> > I am also using a 2 week old A7N8X Deluxe, v2 with the latest 1007 BIOS.
> > I AM able to run 2.6 Test 11 with APIC, Local APIC and ACPI support
> > turned on (SMP off, Preemptible Kernel off).
> 
> Unfortunately, I have the exact same configuration, with massive
> lockups. Could you try executing "hdparm -t /dev/<someharddisk>"
> several times and see if it lockups?
> 

I just ran it 20 times non stop, also compiling in the background..  +
evolution, apache2, mysql, xchat, mozilla.. gkrellm.. etc No hassles.
Uptime is now over 18 hours.

Spec is:
a7n8x deluxe
2600+ 333mhz (not overclocked)
2x256ddr 400mhz running in dual ddr mode
80gb 8mb cache maxtor (hda) and a dvd rw (hdc) and cd rom (hdd)
radeon 9000 pro

regards
Craig




