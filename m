Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270169AbTGUOvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270173AbTGUOvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:51:47 -0400
Received: from colin2.muc.de ([193.149.48.15]:24585 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S270169AbTGUOvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:51:42 -0400
Date: 21 Jul 2003 17:06:43 +0200
Date: Mon, 21 Jul 2003 17:06:43 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andi Kleen <ak@muc.de>, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: KDB in the mainstream 2.4.x kernels?
Message-ID: <20030721150643.GA70173@colin2.muc.de>
References: <m3smp3y38y.fsf@averell.firstfloor.org> <1681.1058705718@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681.1058705718@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 10:55:18PM +1000, Keith Owens wrote:
> On Fri, 18 Jul 2003 22:43:57 +0200, 
> >I actually started on porting the KDB backtracer recently to get
> >reliable frame pointer based backtraces, but it turns out the code
> >for that is so complicated and ugly that the chances of ever merging
> >it would be very slim.
> 
> Mainly because the kernel is full of special cases and i386 provides no

Yes I agree. It is an ugly problem, which usually results in ugly
solutions too.

-Andi
