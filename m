Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262797AbVCDLyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbVCDLyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbVCDLyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:54:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14862 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262874AbVCDLQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:16:42 -0500
Date: Fri, 4 Mar 2005 11:16:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ian Campbell <icampbell@arcom.com>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304111628.D3932@flint.arm.linux.org.uk>
Mail-Followup-To: Ian Campbell <icampbell@arcom.com>,
	Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <1109934698.7304.2.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1109934698.7304.2.camel@icampbell-debian>; from icampbell@arcom.com on Fri, Mar 04, 2005 at 11:11:38AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 11:11:38AM +0000, Ian Campbell wrote:
> On Fri, 2005-03-04 at 10:52 +0000, Russell King wrote:
> > Unfortunately, http://l4x.org/k/ doesn't save any build logs for
> > investigation.
> 
> If you click the 'Fail' then it seems to keep the make output etc.

elinks doesn't show any of the "fail" in the matrix as links - this
seems to be using javascript.

In fact there doesn't appear to be a reason to use javascript for
this - it seems to be implementing a standard link to:

	http://l4x.org/k/?d=<number>

which can be done just as well with standard HTML without need to
resort to javascript.  Plus it works with a wider range of browsers.
Including those used by certain blind developers in this community
who are completely unable to use any form of GUI.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
