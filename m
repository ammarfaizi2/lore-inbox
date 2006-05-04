Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWEDNIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWEDNIZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 09:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWEDNIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 09:08:25 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:34717 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751029AbWEDNIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 09:08:24 -0400
Date: Thu, 4 May 2006 15:08:22 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Yogesh Pahilwan <pahilwan.yogesh@spsoftindia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Generic SATA driver which works with Marvell SATA
Message-ID: <20060504130822.GB16570@harddisk-recovery.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAA4EKnrx4E+kKrTaa+ZxzZDAEAAAAA@spsoftindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAA4EKnrx4E+kKrTaa+ZxzZDAEAAAAA@spsoftindia.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 06:29:04PM +0530, Yogesh Pahilwan wrote:
> Is there any generic SATA driver available which should work with Marvell
> SATA disks? 

If the disk behaves like a standard SATA disk the sd driver should work
just fine (like with any other SATA disk).

> Where can I download this driver?

It comes free with your kernel source.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
