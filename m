Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932938AbWKLPuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbWKLPuP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 10:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932939AbWKLPuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 10:50:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19919 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932938AbWKLPuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 10:50:13 -0500
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
In-Reply-To: <20061112152154.GA3382@stusta.de>
References: <20061111100038.6277efd4.akpm@osdl.org>
	 <1163268603.3293.45.camel@laptopd505.fenrus.org>
	 <20061111101942.5f3f2537.akpm@osdl.org>
	 <1163332237.3293.100.camel@laptopd505.fenrus.org>
	 <20061112125357.GH25057@stusta.de>
	 <1163337376.3293.120.camel@laptopd505.fenrus.org>
	 <20061112133759.GK25057@stusta.de>
	 <1163339868.3293.126.camel@laptopd505.fenrus.org>
	 <20061112141016.GA5297@stusta.de>
	 <1163340998.3293.131.camel@laptopd505.fenrus.org>
	 <20061112152154.GA3382@stusta.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 12 Nov 2006 16:50:03 +0100
Message-Id: <1163346604.15249.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But if APIC is even used on my more than 1 year old 40 Euro Socket A 

once sparrow does not a summer make.


now can we get constructive again. If you find a real case where noapic
is needed on an SMP machine, preferably one where it wasn't needed
before earlier in 2.6, let us know; it's worthwhile to chase those down
since we know it's a decent use case and it's not flaky hardware.


