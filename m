Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263073AbVCEM0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbVCEM0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 07:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVCEM0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 07:26:53 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:57832 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S263073AbVCEM0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 07:26:44 -0500
Date: Sat, 5 Mar 2005 13:26:40 +0100
From: David Weinehall <tao@acc.umu.se>
To: Ian Campbell <icampbell@arcom.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050305122640.GV19998@khan.acc.umu.se>
Mail-Followup-To: Ian Campbell <icampbell@arcom.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <1109934698.7304.2.camel@icampbell-debian> <20050304111628.D3932@flint.arm.linux.org.uk> <1109935938.7304.8.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109935938.7304.8.camel@icampbell-debian>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 11:32:18AM +0000, Ian Campbell wrote:
> On Fri, 2005-03-04 at 11:16 +0000, Russell King wrote:
> > On Fri, Mar 04, 2005 at 11:11:38AM +0000, Ian Campbell wrote:
> > > On Fri, 2005-03-04 at 10:52 +0000, Russell King wrote:
> > > > Unfortunately, http://l4x.org/k/ doesn't save any build logs for
> > > > investigation.
> > > 
> > > If you click the 'Fail' then it seems to keep the make output etc.
> > 
> > elinks doesn't show any of the "fail" in the matrix as links - this
> > seems to be using javascript.
> > 
> > In fact there doesn't appear to be a reason to use javascript for
> > this - it seems to be implementing a standard link to:
> 
> The links and row headers high-light when you mouse over each cell,
> which appears to be why there is javascript involved at all.
> 
> I don't know if javascript is necessary for that feature, but I agree
> that using it for the links seems wrong.

No it isn't necessary; the CSS attribute :hover is the correct way to do
this.  Using Javascript for any kind of design is just wrong, wrong,
wrong.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
