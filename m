Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263339AbTCNOmq>; Fri, 14 Mar 2003 09:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263340AbTCNOmq>; Fri, 14 Mar 2003 09:42:46 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:7177 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S263339AbTCNOmo>; Fri, 14 Mar 2003 09:42:44 -0500
Date: Fri, 14 Mar 2003 07:53:05 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Terry Barnaby <terry@beam.ltd.uk>, mmadore@aslab.com,
       linux-kernel@vger.kernel.org
Subject: Re: Reproducible SCSI Error with Adaptec 7902
Message-ID: <1999490000.1047653585@aslan.scsiguy.com>
In-Reply-To: <3E71B629.60204@beam.ltd.uk>
References: <3E71B629.60204@beam.ltd.uk>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Our system is:
> System: Dual Xeon 2.4GHz system using SuperMicro X5DA8 Motherboard.
> SCSI: Adaptec 7902 onboard dual channel SCSI controller
> Disks: 2 off Quantum Atlas 10K2 18G (160LW), 1 of Quantum 9G (80LW)
> Disks: 1 off Seagate ST336607LW 36G (320LW)
> System: RedHat 7.3 with updates to 18/02/03
> Kernel: 2.4.18-24.7.xsmp
> Aic79xx Driver: versions 1.0.0 and 1.1.0

Is there some reason why you are using such old versions of the aic79xx
driver?  You can obtain the latest version of the driver from here:

http://people.FreeBSD.org/~gibbs/linux/RPM/aic79xx/
http://people.FreeBSD.org/~gibbs/linux/DUD/aic79xx/

or in source form for a 2.4.X or 2.5.X kernel from here:

http://people.freebsd.org/~gibbs/linux/SRC/

--
Justin

