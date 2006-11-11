Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754891AbWKKWuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbWKKWuD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 17:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754892AbWKKWuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 17:50:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:13735 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1754891AbWKKWuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 17:50:00 -0500
Subject: RE: Fwd: [Suspend-devel] resume not working on acer ferrari 4005
	with radeonfb enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>
Cc: Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-fbdev-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl,
       Hoffmann@albercik.sisk.pl
In-Reply-To: <D0233BCDB5857443B48E64A79E24B8CE6B5438@labex2.corp.trema.com>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5438@labex2.corp.trema.com>
Content-Type: text/plain
Date: Sun, 12 Nov 2006 09:49:39 +1100
Message-Id: <1163285379.4982.233.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Then the radeonfb doesn't kick in at all (guess some pci ids are added
> in that patch).
> 
> BTW: resume/suspend works ok if I have the vesa fb enabled.

In that case (vesafb), when does the screen come back precisely ? Do you
get console mode back and then X ? Or it only comes back when going back
to X ? Do you have some userland-type vbetool thingy that bring it
back ?

Ben.


