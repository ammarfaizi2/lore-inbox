Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWGVAV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWGVAV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 20:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWGVAV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 20:21:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42140 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750767AbWGVAV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 20:21:27 -0400
Date: Fri, 21 Jul 2006 17:21:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: tytso@mit.edu, auke-jan.h.kok@intel.com, pavel@ucw.cz, cramerj@intel.com,
       john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: e1000: "fix" it on thinkpad x60 / eeprom checksum read fails
Message-Id: <20060721172111.51419511.akpm@osdl.org>
In-Reply-To: <44C0F13E.2030008@intel.com>
References: <20060721005832.GA1889@elf.ucw.cz>
	<44BFADA6.6090909@intel.com>
	<20060720170758.GA9938@atrey.karlin.mff.cuni.cz>
	<44BFBE9F.7070600@intel.com>
	<20060721064105.aa960acd.akpm@osdl.org>
	<20060721151239.GC2290@thunk.org>
	<44C0F13E.2030008@intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2006 08:22:38 -0700
Auke Kok <auke-jan.h.kok@intel.com> wrote:

> > And if someone who understands all of these details could put a note
> > in the thinkwiki (say, here:
> > http://www.thinkwiki.org/wiki/Ethernet_Controllers#Intel_Gigabit_.2810.2F100.2F1000.29)
> > it would be greatly appreciated.
> > 
> 
> why don't I do that :)
> 
> 
> Andrew: I'm contemplating that printk...

Print the wiki URL ;)
