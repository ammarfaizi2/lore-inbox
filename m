Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264466AbTLCA70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTLCA70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:59:26 -0500
Received: from hqemgate00.nvidia.com ([216.228.112.144]:20233 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S264466AbTLCA7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:59:25 -0500
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F86B@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Ian Kumlien'" <pomac@vapor.com>, b@netzentry.com
Cc: ross.alexander@uk.neceur.com, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, cbradney@zip.com.au, forming@charter.net
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
Date: Tue, 2 Dec 2003 16:58:15 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ian Kumlien [mailto:pomac@vapor.com] 
> Sent: Tuesday, December 02, 2003 4:47 PM
>
> On Wed, 2003-12-03 at 00:36, b@netzentry.com wrote:
> > About the IDE, it seems to be the easiest way to promote the
> > problem but time seems to be the biggest factor. Some have
> > suggested wrt this NFORCE2 problem that idle time makes it
> > worse, but I've seen the hang under both conditions.
> 
> Well, IDE is what i'd blame. My original experience about lost
> interrupts leads me to ide. Since i never loose interrupts without
> io-apic.

Can someone who has a system showing this problem try booting from a PCI IDE
card to see if it makes any difference?  I'd try the experiemnt here, but I
can't reproduce the hanging that's being reported.

-Allen
