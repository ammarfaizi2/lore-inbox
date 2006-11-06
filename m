Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423560AbWKFGAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423560AbWKFGAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 01:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423564AbWKFGAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 01:00:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26635 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423560AbWKFGAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 01:00:19 -0500
Date: Mon, 6 Nov 2006 07:00:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christian <christiand59@web.de>
Cc: Dave Jones <davej@redhat.com>,
       Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Message-ID: <20061106060021.GD5778@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <454AFD01.4080306@linux.intel.com> <20061103155656.GA1000@redhat.com> <200611051832.13285.christiand59@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611051832.13285.christiand59@web.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 06:32:12PM +0100, Christian wrote:
> Am Freitag, 3. November 2006 16:56 schrieb Dave Jones:
> > On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
> >  > Could this be a problem?
> >  > --------------------
> >  > ...
> >  > CONFIG_ACPI_PROCESSOR=m
> >  > ...
> >  > CONFIG_X86_POWERNOW_K8=y
> >
> > Hmm, possibly.  Christian, does it work again if you set them both to =y ?
> 
> Yes, it works now! Only the change to CONFIG_ACPI_PROCESSOR=y made it work 
> again!

You said 2.6.18 worked for you.

Did you have CONFIG_ACPI_PROCESSOR=y in 2.6.18, or did
CONFIG_ACPI_PROCESSOR=m, CONFIG_X86_POWERNOW_K8=y work for you in 2.6.18?

> Nice catch ;-)
> 
> Thank you very much!
> -Christian

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

