Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTAUGAq>; Tue, 21 Jan 2003 01:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbTAUGAp>; Tue, 21 Jan 2003 01:00:45 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:6784 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S263991AbTAUGAo>; Tue, 21 Jan 2003 01:00:44 -0500
Subject: Re: [2.5 patch] MegaRAID driver: remove kernel 2.0 and 2.2 code
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: groudier@free.fr, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030118162243.GF10647@fs.tum.de>
References: <20030118162243.GF10647@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043117030.13113.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 21 Jan 2003 02:43:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-18 at 16:22, Adrian Bunk wrote:
> The patch below removes obsolete #if'd code for kernel 2.0 and 2.2 from
> drivers/scsi/megaraid.{h,c} (this includes the expansion of some
> #define's that were definded differently for different kernel versions).
> 
> I've tested the compilation with 2.5.59.

AMI still issue 2.2 versions of this driver so its probably excessive
(AMI ? -- LSI now I guess)

