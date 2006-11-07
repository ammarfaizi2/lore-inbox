Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWKGNBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWKGNBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWKGNBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:01:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16068 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932575AbWKGNBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:01:13 -0500
Subject: Re: [PATCH 12/14] KVM: x86 emulator
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Pavel Machek <pavel@ucw.cz>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <4550823E.2070108@qumranet.com>
References: <454E4941.7000108@qumranet.com>
	 <20061105204035.DF0F62500A7@cleopatra.q>
	 <20061107124912.GA23118@elf.ucw.cz>  <4550823E.2070108@qumranet.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 07 Nov 2006 14:00:59 +0100
Message-Id: <1162904459.3138.142.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The entire patchset is GPL'ed.  Do you mean to make it explicit?  If so, 
> how?  I'd rather not copy the entire license into each file.

a simple one liner like
"This file is licensed under the terms of the GPL v2 license"
(add "or later" if you feel like doing that)
is going to be generally useful. 

At least many many legal departments really prefer at least that minimum
line to be there for each file; some even want a much longer blurb.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

