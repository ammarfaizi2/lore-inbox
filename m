Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753367AbWKQWfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbWKQWfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbWKQWfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:35:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:7053 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1753367AbWKQWfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:35:18 -0500
Subject: RE: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working
	onacer ferrari 4005 with radeonfb enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Hoffmann <email@christianhoffmann.info>
Cc: "'Christian Hoffmann'" <chrmhoffmann@gmail.com>,
       "'Stuffed Crust'" <pizza@shaftnet.org>,
       "'Rafael J. Wysocki'" <rjw@sisk.pl>,
       linux-fbdev-devel@lists.sourceforge.net,
       "'Christian Hoffmann'" <Christian.Hoffmann@wallstreetsystems.com>,
       "'Andrew Morton'" <akpm@osdl.org>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'Pavel Machek'" <pavel@ucw.cz>
In-Reply-To: <000701c70a94$1d9c2b40$6700a8c0@r2d2>
References: <000701c70a94$1d9c2b40$6700a8c0@r2d2>
Content-Type: text/plain
Date: Sat, 18 Nov 2006 09:34:42 +1100
Message-Id: <1163802883.5826.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sorry, but how do I do that? 
> 
> Chris
> 
> BTW: yes, it's a PCI-express card.

You need to wit a bit for me to check wether we have added the PCI-E
specific registers to radeontool dump :-)

Ben.


