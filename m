Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270243AbTG1Onr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 10:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270248AbTG1Onr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 10:43:47 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:64017 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S270243AbTG1Onq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 10:43:46 -0400
Date: Mon, 28 Jul 2003 08:59:01 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, davem@redhat.com,
       alan@lxorguk.ukuu.org.uk, James.Bottomley@SteelEye.com, axboe@suse.de,
       suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       alex_williamson@hp.com, bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030728145901.GA18738@dsl2.external.hp.com>
References: <20030708213427.39de0195.ak@suse.de> <20030708.150433.104048841.davem@redhat.com> <20030708222545.GC6787@dsl2.external.hp.com> <20030708.152314.115928676.davem@redhat.com> <20030723114006.GA28688@dsl2.external.hp.com> <20030728131513.5d4b1bd3.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728131513.5d4b1bd3.ak@suse.de>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 01:15:13PM +0200, Andi Kleen wrote:
> Download reaim from sourceforge

http://lwn.net/Articles/20733/
	"(couldn't think of a better name, sorry)"

I was happy when "apt-get install reaim" just worked... *sigh*
But figured out "reaim" != "re-aim-7".
debian doesn't know anything about re-aim-7. :^(

http://sourceforge.org/projects/re-aim-7
	We're Sorry.
	The SourceForge.net Website is currently down for maintenance.
	We will be back shortly

willy mentioned it's on OSDL too. Will look for that next.

> Use the workfile.new_dbase test
> Run it with 100-500 users (reaim -f workfile... -s 100 -e 500 -i 100) 
> I tested with ext3 on a single SCSI disk.

thanks Andi - hopefully I can generate results this afternoon
when I've got connectivity again.

grant
