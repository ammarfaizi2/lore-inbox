Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424594AbWKKSKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424594AbWKKSKS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbWKKSKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:10:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9397 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754861AbWKKSKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:10:17 -0500
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru
In-Reply-To: <20061111100038.6277efd4.akpm@osdl.org>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org>
	 <20061111100038.6277efd4.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 11 Nov 2006 19:10:03 +0100
Message-Id: <1163268603.3293.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Kernel started with noapic option, cause it hands on load without this option.
> 
> Him and a million other people.  I know we broke APIC.  Around 2.6.9, I
> think.


is that when the "enable apic even on UP so that distro kernels can
install on the ibm x44*" patches went in?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

