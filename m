Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUBOSm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 13:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUBOSm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 13:42:59 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:48542 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265144AbUBOSm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 13:42:58 -0500
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
From: Christophe Saout <christophe@saout.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Michal Kwolek <miho@centrum.cz>, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040215180226.A8426@infradead.org>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
Content-Type: text/plain
Message-Id: <1076870572.20140.16.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 19:42:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, den 15.02.2004 schrieb Christoph Hellwig um 19:02:

> On Sun, Feb 15, 2004 at 06:34:31PM +0100, Christophe Saout wrote:
> > could you try dm-crypt? It uses the device-mapper instead of the loop
> > device but should be compatible (uses cryptoapi too). It's going to be
> > added to the kernel soon I hope.
> 
> What's holding it back?  I'd rather get rid of all the cryptoloop crap
> sooner or later.

Well, nothing. It's in the dm-unstable tree for some time now. It
depends on when Joe plans to submit it. His last words were "in the next
couple of months". I don't know what that means exactly.


