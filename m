Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbUKSNlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUKSNlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUKSNjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:39:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12723 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261408AbUKSNiM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:38:12 -0500
Date: Thu, 18 Nov 2004 15:58:41 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: "O.Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.28-rc4
Message-ID: <20041118175841.GB27657@logos.cnet>
References: <419B1813.80002@ttnet.net.tr> <20041118204841.GA11682@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20041118204841.GA11682@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.5.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 12:48:41PM -0800, Barry K. Nathan wrote:
> On Wed, Nov 17, 2004 at 11:21:23AM +0200, O.Sezer wrote:
> > >Jakub Jelínek:
> > >  o binfmt_elf: handle p_filesz == 0 on PT_INTERP section
> > 
> > Another FYI: There were two successive binfmt_elf 2.6-backports posted
> > by Barry Nathan here;  "ELF fixes for executables with huge BSS":
> > 
> > http://marc.theaimsgroup.com/?t=109850369800001&r=1&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109850420711579&w=2
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109850420729735&w=2
> > 
> > but it may be too late for 2.4.28.
> 
> Marcelo and I discussed this via private e-mail; it's in the queue for
> 2.4.29-pre. I think in the end we both agreed that it's too late in the
> 2.4.28 cycle to include these patches.

Yep - they will be in 2.4.29pre.

Thanks guys!
