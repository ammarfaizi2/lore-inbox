Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbTEFEo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTEFEo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:44:28 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:34314 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262359AbTEFEo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:44:27 -0400
Date: Tue, 6 May 2003 06:56:31 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Stian Jordet <liste@jordet.nu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: USB not working with 2.5.69, worked with .68
Message-ID: <20030506045631.GC5326@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <1052168060.826.8.camel@chevrolet.hybel> <20030505215141.GB3111@kroah.com> <1052176021.1092.7.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052176021.1092.7.camel@chevrolet.hybel>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stian Jordet <liste@jordet.nu>
Date: Tue, May 06, 2003 at 01:07:02AM +0200
> A little off-topic rant about my motherboard:
> 
> I have a ASUS CUV266-DLS motherboard. Dual P3, integrated SCSI and
> ethernet. Since it is smp, I have to use ACPI to power it off.
> 

try

apm=power-off

on the kernel command line.

HTH,
Jurriaan
-- 
MSDOS didn't get as bad as it is overnight -- it took over ten years
of careful development.
	dmeggins@aix1.uottawa.ca
Debian (Unstable) GNU/Linux 2.5.69 4112 bogomips load av: 0.19 0.43 0.37
