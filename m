Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbVCDL5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbVCDL5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVCDLzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:55:47 -0500
Received: from webapps.arcom.com ([194.200.159.168]:4369 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262902AbVCDLcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:32:31 -0500
Subject: Re: RFD: Kernel release numbering
From: Ian Campbell <icampbell@arcom.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050304111628.D3932@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	 <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com>
	 <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	 <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org>
	 <20050304105247.B3932@flint.arm.linux.org.uk>
	 <1109934698.7304.2.camel@icampbell-debian>
	 <20050304111628.D3932@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Fri, 04 Mar 2005 11:32:18 +0000
Message-Id: <1109935938.7304.8.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2005 11:37:54.0093 (UTC) FILETIME=[9AA685D0:01C520AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 11:16 +0000, Russell King wrote:
> On Fri, Mar 04, 2005 at 11:11:38AM +0000, Ian Campbell wrote:
> > On Fri, 2005-03-04 at 10:52 +0000, Russell King wrote:
> > > Unfortunately, http://l4x.org/k/ doesn't save any build logs for
> > > investigation.
> > 
> > If you click the 'Fail' then it seems to keep the make output etc.
> 
> elinks doesn't show any of the "fail" in the matrix as links - this
> seems to be using javascript.
> 
> In fact there doesn't appear to be a reason to use javascript for
> this - it seems to be implementing a standard link to:

The links and row headers high-light when you mouse over each cell,
which appears to be why there is javascript involved at all.

I don't know if javascript is necessary for that feature, but I agree
that using it for the links seems wrong.

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

