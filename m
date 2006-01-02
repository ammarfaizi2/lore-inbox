Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWABQl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWABQl3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWABQl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:41:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49835 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750829AbWABQl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:41:27 -0500
Date: Mon, 2 Jan 2006 17:41:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/19] mutex subsystem, -V10
Message-ID: <20060102164115.GA2176@elte.hu>
References: <20060102163324.GA31501@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102163324.GA31501@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> - added "From:" attribution lines. (the S-o-b lines were OK.)

oh well - my mailer merged those lines into the email header (doh!).  
The next series will fix this - but i wont re-send just for this ... 
Sorry about this.

	Ingo
