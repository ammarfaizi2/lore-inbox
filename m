Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVBOUoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVBOUoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVBOUoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:44:24 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:13721 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261883AbVBOUnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:43:31 -0500
Subject: Re: [ACPI] Re: Call for help: list of machines with working S3
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Lorenzo Colitti <lorenzo@colitti.com>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
In-Reply-To: <200502151742.55362.s0348365@sms.ed.ac.uk>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <1108482083.12031.10.camel@elrond.flymine.org>
	 <42122054.8010408@colitti.com>  <200502151742.55362.s0348365@sms.ed.ac.uk>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 20:43:14 +0000
Message-Id: <1108500194.12031.21.camel@elrond.flymine.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 17:42 +0000, Alistair John Strachan wrote:

>                 Vendor: Hewlett-Packard
> -               Version: 68BDD Ver. F.0F
> -               Release Date: 07/23/2004
> +               Version: 68BDD Ver. F.11
> +               Release Date: 11/22/2004

Ok, so you both have different BIOS versions and different CPUs.
Everything else looks pretty identical. Could you both
stick /proc/acpi/dsdt up somewhere so I can check if there are any
relevant looking differences?

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org

