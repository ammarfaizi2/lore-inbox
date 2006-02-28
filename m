Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWB1MDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWB1MDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWB1MDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:03:40 -0500
Received: from mail.dvmed.net ([216.237.124.58]:34692 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932325AbWB1MDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:03:38 -0500
Message-ID: <44043C18.2070502@pobox.com>
Date: Tue, 28 Feb 2006 07:03:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 7/13] ATA ACPI: more Makefile/Kconfig
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135802.60ab42ab.randy_d_dunlap@linux.intel.com> <20060228114915.GC4081@elf.ucw.cz>
In-Reply-To: <20060228114915.GC4081@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On St 22-02-06 13:58:02, Randy Dunlap wrote:
> 
>>From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
>>
>>Simplify Makefile.
>>Add Kconfig help.
> 
> 
> Could you fold this with patch 1 of series? Introducing too complex
> Makefile then fixing it makes review quite "interetsing". 

Agreed.  Patches should be folded together...

	Jeff



