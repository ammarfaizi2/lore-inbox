Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbUJ1TE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbUJ1TE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 15:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbUJ1TE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 15:04:56 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:43413 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S261970AbUJ1TAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 15:00:31 -0400
Subject: Re: Intel also needs convincing on firmware licensing.
From: Dax Kelson <dax@gurulabs.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       Han Boetes <han@mijncomputer.nl>
In-Reply-To: <200410280850.51033.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20041028022532.GX26130@boetes.org>
	 <200410272346.12283.gene.heskett@verizon.net>
	 <200410280850.51033.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1098990028.3856.277.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Oct 2004 13:00:28 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 23:50, Denis Vlasenko wrote:

> However, disassemblers do exist. Hiding secrets in binary .o
> files is silly.

Who cares what the secrets in the firmware are. 

Again, it does not execute on your computer's CPU. It does not taint the
kernel. The Linux kernel driver is 100% GPLd, no binary blobs.

Nearly all the devices in your computer have firmware. Your keyboard,
your CDROM drive, your graphics card. It is hypocritical to clamor for
the source code to the IPW2100/2200/etc while not clamoring for the
source code to all the other firmwares in your computer.

It is unfortunate that the firmware isn't stored onboard the Intel card,
and instead needs to be loaded, however, this is a pretty minor
inconvenience. 

The only remaining issue, if the redistribution terms of the firmware
are liberal enough so that RHEL/FC and other free minded distros can
include the files out of the box in /lib/hotplug/firmware directory.

Apparently the terms are OK with SUSE as they include the firmware in
SUSE LINUX v9.2. This isn't a huge surprise as SUSE has always been more
willing to bundle less than free works.

Dax Kelson
Guru Labs

