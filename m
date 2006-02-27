Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751737AbWB0VRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbWB0VRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWB0VRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:17:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:932 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751300AbWB0VRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:17:30 -0500
Subject: Re: o_sync in vfat driver
From: Arjan van de Ven <arjan@infradead.org>
To: col-pepper@piments.com
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
In-Reply-To: <op.s5ngtbpsj68xd1@mail.piments.com>
References: <op.s5cj47sxj68xd1@mail.piments.com>
	 <op.s5jpqvwhui3qek@mail.piments.com> <op.s5kxhyzgfx0war@mail.piments.com>
	 <op.s5kx7xhfj68xd1@mail.piments.com> <op.s5kya3t0j68xd1@mail.piments.com>
	 <op.s5ky2dbcj68xd1@mail.piments.com> <op.s5ky71nwj68xd1@mail.piments.com>
	 <op.s5kzao2jj68xd1@mail.piments.com> <op.s5lq2hllj68xd1@mail.piments.com>
	 <20060227132848.GA27601@csclub.uwaterloo.ca>
	 <1141048228.2992.106.camel@laptopd505.fenrus.org>
	 <1141049176.18855.4.camel@imp.csi.cam.ac.uk>
	 <1141050437.2992.111.camel@laptopd505.fenrus.org>
	 <1141051305.18855.21.camel@imp.csi.cam.ac.uk>
	 <op.s5ngtbpsj68xd1@mail.piments.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 22:17:21 +0100
Message-Id: <1141075047.2992.166.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Telling a user who has just burnt out a brand new 1GB usb device he should  
> have RTFM and modified that HAL configuration to insure it did not use  
> sync it not likely to win much confidence in the linux kernel.

or in HAL. really.


there was a very long discussion abuot kernel stability.
The problem is that once depending on the absence of a feature becomes
ABI ... there is a big problem.


