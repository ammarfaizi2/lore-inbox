Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263347AbUCTKsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbUCTKsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:48:51 -0500
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:19410 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S263347AbUCTKsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:48:45 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: idle Athlon with IOAPIC is 10C warmer since 2.6.3-bk1
Date: Sat, 20 Mar 2004 20:50:46 +1000
User-Agent: KMail/1.5.1
Cc: Len Brown <len.brown@intel.com>,
       Thomas Schlichter <thomas.schlichter@web.de>,
       linux-kernel@vger.kernel.org
References: <200403181019.02636.ross@datscreative.com.au> <200403202019.44612.ross@datscreative.com.au> <405C1C0D.9050108@gmx.de>
In-Reply-To: <405C1C0D.9050108@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403202050.46298.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 March 2004 20:25, Prakash K. Cheemplavam wrote:
> Ross Dickson wrote:
> >>[snip]
> >>
> >>>
> >>>Actually I think it is that we don't _count_ C1 usage.
> >>
> >>Hmm, OK, then I am really puzzled what specifically about mm sources 
> >>make my idle temps hotter, as I still couldn't properly resolve it what 
> >>is causing it. I thought ACPI, but no, using APM only does the same (apm 
> >>only with vanilla is low temp though.)
> > 
> > 
> > Have you seen this thread, it may be relevant?
> > Re: [2.6.4-rc2] bogus semicolon behind if()
> > http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/4170.html
> 
> Hi Ross, I don't think so, as I currently don't use APIC and thus fix in 
> above post wouldn't help me. Or should I read further?

Hmm Valid point.
bye
Ross.

> 
> cya,
> 
> Prakash
> 
> 
> 
> 

