Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278653AbRKHWCj>; Thu, 8 Nov 2001 17:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278649AbRKHWCa>; Thu, 8 Nov 2001 17:02:30 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4350 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278643AbRKHWCO>;
	Thu, 8 Nov 2001 17:02:14 -0500
Date: Thu, 8 Nov 2001 15:01:58 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: aputhiya <aputhiya@temple.edu>
Cc: linux-smp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: APIC Cluster Model
Message-ID: <20011108150158.D9043@lynx.no>
Mail-Followup-To: aputhiya <aputhiya@temple.edu>, linux-smp@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BFC7A20@smaug.ocis.temple.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BFC7A20@smaug.ocis.temple.edu>; from aputhiya@temple.edu on Thu, Nov 08, 2001 at 04:28:51PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 08, 2001  16:28 -0500, aputhiya wrote:
> Linux uses FLAT MODEL for setting up the IO APIC for SMP machines (Intel
> IA-32  arch). I was wondering if the CLUSTER MODEL has been implemented
> in any of  later SMP kernels?

Yes, the IBM folks implemented this for CONFIG_MULITQUAD.  I don't know
the details, but it is in stock 2.4.13+ kernels at least.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

