Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTF0Q5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 12:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTF0Q5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 12:57:19 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:27264 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S264490AbTF0Q5S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 12:57:18 -0400
Subject: Re: Linux 2.4.21-ac3
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306251636.h5PGag417884@devserv.devel.redhat.com>
References: <200306251636.h5PGag417884@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1056733889.746.5.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 27 Jun 2003 20:11:29 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 19:36, Alan Cox wrote:
> Linux 2.4.1-ac3
> o	Fix an hpt driver bug triggered by the new HPT 	(me)
> 	BIOS
> o	Initial VIA and S3 DRM modules merges		(VIA)
> 	| These are marked up with some warnings and need
> 	| a chunk of clean up work yet.
> o	btaudio update					(Gerd Knorr)
> o	Backport 2.5 ipc/sem.c fix			(Manfred Spraul)
> o	Fix scsi_register failure path for aacraid	(Michael Still)
> o	First crack at fixing the ide reset oopses	(me)
> o	Fix the incompatibility between via audio and	(me)
> 	esd/gnome desktops

Looks like ICH5-SATA IDE was also disabled in favor of a SCSI ATA
driver. Caused me a momentary headache before I figured out why my disk
drives went away. :)

	MikaL

