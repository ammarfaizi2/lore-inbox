Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTJVIyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 04:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTJVIyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 04:54:50 -0400
Received: from swszl.szkp.uni-miskolc.hu ([193.6.2.24]:20193 "EHLO
	swszl.szkp.uni-miskolc.hu") by vger.kernel.org with ESMTP
	id S263189AbTJVIyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 04:54:50 -0400
Date: Wed, 22 Oct 2003 10:54:49 +0200
From: Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>
To: linux-kernel@vger.kernel.org
Cc: Samuel Kvasnica <samuel.kvasnica@tuwien.ac.at>
Subject: Re: nforce2 random lockups - still no solution ?
Message-ID: <20031022085449.GA21393@swszl.szkp.uni-miskolc.hu>
References: <3F95748E.8020202@tuwien.ac.at> <200310211113.00326.lkml@lpbproductions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200310211113.00326.lkml@lpbproductions.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 11:13:00AM -0700, Matt H. wrote:
> Turn off apic in the bios.. it should then work well .. 
> 
> On Tuesday 21 October 2003 11:01 am, Samuel Kvasnica wrote:
> > Hello,
> >
> > Last few weeks I spent quite much time trying to get working two nforce2
> > chipset based motherboards with latest linux 2.4.22 - ASUS A7N8 Deluxe
> > 2.0 and
> > MSI K7N2 Delta. Althought the latest kernel version already detects
> ..

If turning off APIC doesn't solve the problem, try a kernel with 
LOCAL APIC support turned off. 


	Gabor
