Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUBOOCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 09:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUBOOCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 09:02:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33736 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264917AbUBOOCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 09:02:32 -0500
Date: Sun, 15 Feb 2004 15:02:26 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Vincent Hanquez <tab@snarc.org>
Cc: Colin <cwv@cwv.tor.istop.com>, linux-kernel@vger.kernel.org,
       gadgeteer@elegantinnovations.org
Subject: Re: Radeon 9600 PCI IDs
Message-ID: <20040215140226.GX1308@fs.tum.de>
References: <40299791.7070504@cwv.tor.istop.com> <20040214120820.GH1308@fs.tum.de> <20040214163419.GA7676@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214163419.GA7676@snarc.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 05:34:19PM +0100, Vincent Hanquez wrote:
> On Sat, Feb 14, 2004 at 01:08:20PM +0100, Adrian Bunk wrote:
> > On Tue, Feb 10, 2004 at 09:46:41PM -0500, Colin wrote:
> > 
> > > How come the kernel doesn't have any of the IDs for any of the Radeon 9600 
> > > in the pci.ids file?
> > 
> > There are entries for the Radeon RV350 in both 2.4.24 and 2.6.2 .
> 
> We don't have the same 2.6.2 then ;)
>...

My fault, I was looking at include/linux/pci_ids.h ...

> Tab

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

