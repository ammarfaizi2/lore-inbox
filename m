Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTFIVMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTFIVMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:12:14 -0400
Received: from fmr01.intel.com ([192.55.52.18]:45536 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262029AbTFIVMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:12:13 -0400
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2DF@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>
Subject: RE: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Date: Mon, 9 Jun 2003 14:21:03 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Marcelo Tosatti [mailto:marcelo@conectiva.com.br] 
> > > Any chance to get patch against latest -rc7 ?
> >
> > It's big, and deemed too risky. We are shooting for 2.4.22-pre1.
> 
> Just had a few thoughts about that and I want to have a fast 2.4.22
> release (maximum two months). 2.4.21's development time was 
> unnaceptable.
> 
> Lets do the ACPI merge in 2.4.23.

I wouldn't have a problem with this, except that you've been deferring
the ACPI merge for over a year. We've been maintaining this patch
outside the mainline tree for EIGHTEEN MONTHS. Please stop leading me
along. Will you EVER merge it?

I am confident it will merge cleanly.
I am confident it will cause no problems when CONFIG_ACPI=off.
I am confident the total number of working machines will go up.
I am willing to bet $500 of MY OWN MONEY on this.

Talk to me, man. What would make you happy? A lot is riding on this.

Regards -- Andy
