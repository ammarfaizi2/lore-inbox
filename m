Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSLCPSc>; Tue, 3 Dec 2002 10:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSLCPSc>; Tue, 3 Dec 2002 10:18:32 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56736 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261908AbSLCPSb>; Tue, 3 Dec 2002 10:18:31 -0500
Subject: Re: Pair programming and the linux kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sbthomas@calpoly.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <H00031c50f335123.1038900728.seurat.artisan.calpoly.edu@MHS>
References: <H00031c50f335123.1038900728.seurat.artisan.calpoly.edu@MHS>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 16:00:02 +0000
Message-Id: <1038931202.11439.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 07:42, sbthomas@calpoly.edu wrote:
> Is anyone aware if any significant parts of the Linux kernel have 
> been "pair-programmed?" Not necessarily the whole XP definition, but 
> has anyone actually made a point to sit down with someone else and 
> design a solution to add a feature or fix a bug? I'm doing a paper on 
> the benefits of using pair programming in operating systems work. Any 
> other thoughts or questions?

Only two people ? The core kernel code gets read by several more people
than that it most cases. Drivers is probably more variable, depending on
how common the device is.

One thing that certainly showed up and is much easier to achieve as well
as giving extremely good results is documenting other peoples code. The
documentation process found a lot of driver bugs in Linux and a lot of
bugs in Gnome code too. Not just developer documentation either - user
documentation can have the same effect


