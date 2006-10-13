Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWJMVnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWJMVnF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbWJMVnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:43:05 -0400
Received: from solarneutrino.net ([66.199.224.43]:41996 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1030184AbWJMVnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:43:03 -0400
Date: Fri, 13 Oct 2006 17:42:50 -0400
To: Aleksey Gorelov <dared1st@yahoo.com>
Cc: linux-kernel@vger.kernel.org, xhejtman@mail.muni.cz,
       auke-jan.h.kok@intel.com
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
Message-ID: <20061013214250.GC19608@tau.solarneutrino.net>
References: <20061013214029.35732.qmail@web83103.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061013214029.35732.qmail@web83103.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 02:40:29PM -0700, Aleksey Gorelov wrote:
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org 
> >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ryan Richter
> >Sent: Friday, October 13, 2006 2:26 PM
> >To: linux-kernel@vger.kernel.org
> >Subject: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
> >
> >I have a new system based on the Inter 965G chipset, and all 
> >the kernels
> >I've used - 2.6.18, .19-rc1, and .19-rc2 - have failed to reset the
> >machine on a reboot.  "Machine Restart" is printed, but it just hangs
> >there.  SysRQ is non-functional at that point.
> 
>   The similar issue has been discussed in adjacent thread "Machine
>   reboot". Is it Intel motherboard, or just carries Intel chipset ?
>   Does building e1000 driver as a module and 'rmmod e1000' just before
>   reboot help ?

It's an Intel DG965RY board.  I'll try out your suggestion on Monday.

Thanks,
-ryan
