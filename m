Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTJPKBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTJPKBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:01:24 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:13727 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262782AbTJPKBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:01:23 -0400
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031016091918.GA1002@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org>
	 <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org>
	 <20031016091918.GA1002@casa.fluido.as>
Content-Type: text/plain
Message-Id: <1066298431.1407.119.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 16 Oct 2003 12:00:32 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-16 at 11:19, Carlo E. Prelz wrote:
> 	Subject: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
> 	Date: gio, ott 16, 2003 at 12:27:44 +0100
> 
> Quoting James Simmons (jsimmons@infradead.org):
> 
> > I applied it. I also have Ben's new driver avaiable for testing. 
> > The diff I released uses Ben's new driver but in BK I'm stilling using teh 
> > old driver.
> 
> I am the happy owner of a "Club"-branded Radeon9200 video card. Here
> are my experiences using your diff.
> 
> My card has a PCI id of 5964. Here you can read the output of 'lspci
> -vvv' for it:

My new driver (bk://ppc.bkbits.net/linuxppc-2.5-benh) now uses a copy
of XFree PCI IDs list, making it much easier to keep in sync. It should
also support the 9200.

Ben.


