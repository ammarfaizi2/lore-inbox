Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268543AbTCAKWP>; Sat, 1 Mar 2003 05:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268544AbTCAKWP>; Sat, 1 Mar 2003 05:22:15 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:403 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S268543AbTCAKWO>; Sat, 1 Mar 2003 05:22:14 -0500
Date: Sat, 1 Mar 2003 11:32:34 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: re: Linux 2.4.21pre4-ac5 status report
Message-ID: <20030301103234.GB22135@louise.pinerecords.com>
References: <1046506460.1215.993.camel@sun> <20030301085704.GA22135@louise.pinerecords.com> <1046514580.15694.2.camel@sun>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046514580.15694.2.camel@sun>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [kernel@nn7.de]
> 
> > > [kernel@nn7.de]
> > > 
> > > The promise driver still freezes on my pdc20268 when using >mdma0.
> > 
> > Try upgrading the BIOS on the 20268.  Sounds incredible, but it
> > did solve all the problems I was seeing with the card in Linux.
> 
> I checked for new bioses 2 on thursday -> there where no newer bioses
> available. I guess you have a single pdc20268 which is full of disks
> (i.e. master and slave used?).

I've got a single pdc20268 with just one drive on each channel...
Works nicely with recent -ac kernels.

-- 
Tomas Szepe <szepe@pinerecords.com>
