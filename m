Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTEFNJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTEFNJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:09:50 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:20485 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263201AbTEFNJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:09:49 -0400
Subject: Re: USB not working with 2.5.69, worked with .68
From: Stian Jordet <liste@jordet.nu>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030506045631.GC5326@middle.of.nowhere>
References: <1052168060.826.8.camel@chevrolet.hybel>
	 <20030505215141.GB3111@kroah.com> <1052176021.1092.7.camel@chevrolet.hybel>
	 <20030506045631.GC5326@middle.of.nowhere>
Content-Type: text/plain
Organization: 
Message-Id: <1052227358.705.8.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 May 2003 15:22:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 06.05.2003 kl. 06.56 skrev Jurriaan:
> From: Stian Jordet <liste@jordet.nu>
> Date: Tue, May 06, 2003 at 01:07:02AM +0200
> > A little off-topic rant about my motherboard:
> > 
> > I have a ASUS CUV266-DLS motherboard. Dual P3, integrated SCSI and
> > ethernet. Since it is smp, I have to use ACPI to power it off.
> > 
> 
> try
> 
> apm=power-off
> 
> on the kernel command line.

Thanks, I am aware of this, and I'm using it on several 2.4.x machines.
But I can't seem to get it to work on 2.5, something always segfaults
when it should turn off. But that might improve before 2.6.0. Anyway,
thanks a lot :)

Best regards,
Stian

