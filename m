Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267622AbUG3Gae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267622AbUG3Gae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 02:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUG3Gad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 02:30:33 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29117 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267635AbUG3GaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 02:30:20 -0400
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
From: Robert Love <rml@ximian.com>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Jens Axboe <axboe@suse.de>, "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4109E9F8.9080600@gmx.de>
References: <20040728065319.GD11690@suse.de>
	 <20040728145228.GA9316@redhat.com>
	 <20040728145543.GB18846@devserv.devel.redhat.com>
	 <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de>
	 <1091051858.13651.1.camel@camp4.serpentine.com>
	 <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost>
	 <20040730055333.GC7925@suse.de> <1091167031.1982.13.camel@localhost>
	 <20040730061005.GF18347@suse.de>  <4109E9F8.9080600@gmx.de>
Content-Type: text/plain
Date: Fri, 30 Jul 2004 02:30:21 -0400
Message-Id: <1091169021.2009.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 08:26 +0200, Prakash K. Cheemplavam wrote:

> Could it be famd?

I thought about that, killed it, still happens.

The only "something is poking the drive" theory does not make sense,
though, since it consistently works with some CD's and not others.

	Robert Love


