Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUG3Pdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUG3Pdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 11:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267714AbUG3Pdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 11:33:55 -0400
Received: from peabody.ximian.com ([130.57.169.10]:56767 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267713AbUG3Pdx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 11:33:53 -0400
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
From: Robert Love <rml@ximian.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040730063834.GG18347@suse.de>
References: <20040728145543.GB18846@devserv.devel.redhat.com>
	 <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de>
	 <1091051858.13651.1.camel@camp4.serpentine.com>
	 <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost>
	 <20040730055333.GC7925@suse.de> <1091167031.1982.13.camel@localhost>
	 <20040730061005.GF18347@suse.de> <1091168884.2009.1.camel@localhost>
	 <20040730063834.GG18347@suse.de>
Content-Type: text/plain
Date: Fri, 30 Jul 2004 11:33:59 -0400
Message-Id: <1091201639.1794.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 08:38 +0200, Jens Axboe wrote:

> And the CD that never works, is that consistent across different drives?

Yes.  So in this machine I have two drives (a CD-RW and a DVD-ROM) and
the same disk works in neither.

I think I should do a binary search backward to find where it started
failing.

	Robert Love


