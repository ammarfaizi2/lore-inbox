Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753820AbWKGNoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbWKGNoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbWKGNoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:44:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753820AbWKGNop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:44:45 -0500
Subject: Re: [PATCH 12/14] KVM: x86 emulator
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Pavel Machek <pavel@ucw.cz>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <4550889C.2020708@qumranet.com>
References: <454E4941.7000108@qumranet.com>
	 <20061105204035.DF0F62500A7@cleopatra.q>
	 <20061107124912.GA23118@elf.ucw.cz>  <4550823E.2070108@qumranet.com>
	 <1162904459.3138.142.camel@laptopd505.fenrus.org>
	 <4550889C.2020708@qumranet.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 07 Nov 2006 14:44:30 +0100
Message-Id: <1162907070.3138.150.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 15:22 +0200, Avi Kivity wrote:
> Arjan van de Ven wrote:
> >> The entire patchset is GPL'ed.  Do you mean to make it explicit?  If so, 
> >> how?  I'd rather not copy the entire license into each file.
> >>     
> >
> > a simple one liner like
> > "This file is licensed under the terms of the GPL v2 license"
> > (add "or later" if you feel like doing that)
> > is going to be generally useful. 
> >
> > At least many many legal departments really prefer at least that minimum
> > line to be there for each file; some even want a much longer blurb.
> >   
> 
> Okay.  I hate to use the word "official", but is there an official 
> position on this somewhere?

I don't think there's an hard official rule; just good practice and to
take away any unclarity..
.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

