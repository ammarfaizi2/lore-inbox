Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751893AbWKQSf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbWKQSf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWKQSf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:35:58 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:35821 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750961AbWKQSf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:35:57 -0500
Date: Fri, 17 Nov 2006 18:35:52 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061117183552.GA3621@srcf.ucam.org>
References: <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061107204409.GA37488@vasa.acc.umu.se> <20061107134439.1d54dc66.kristen.c.accardi@intel.com> <20061117102237.GS14886@vasa.acc.umu.se> <20061117151341.GA1162@srcf.ucam.org> <20061117153717.GU14886@vasa.acc.umu.se> <20061117154627.GA1544@srcf.ucam.org> <20061117160810.GW14886@vasa.acc.umu.se> <20061117163128.GA2068@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117163128.GA2068@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 04:31:28PM +0000, Matthew Garrett wrote:

> Possibly what's needed is something like Apple's nullfs 

deadfs, rather.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
