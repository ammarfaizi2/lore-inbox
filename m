Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVBOUcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVBOUcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVBOU37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:29:59 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:13443 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261777AbVBOUVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:21:19 -0500
Subject: Re: [ACPI] Call for help: list of machines with working S3
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Norbert Preining <preining@logic.at>, Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
In-Reply-To: <4212460A.4000100@gmx.net>
References: <20050214211105.GA12808@elf.ucw.cz>
	 <20050215125555.GD16394@gamma.logic.tuwien.ac.at>
	 <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at>
	 <4212460A.4000100@gmx.net>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 20:21:15 +0000
Message-Id: <1108498875.12026.18.camel@elrond.flymine.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 19:57 +0100, Carl-Daniel Hailfinger wrote:

> Kendall Bennett is working with me to get suspend/resume working
> even with framebuffers. Once we have results, I'll post them here.

I've had success using vesafb with vbetool state restoration. vga16fb
ought to work fairly happily.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

