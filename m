Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTJ1JhJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbTJ1JhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:37:09 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52879
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263902AbTJ1JhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:37:06 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: "M. Fioretti" <m.fioretti@inwind.it>, linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Date: Tue, 28 Oct 2003 03:12:20 -0600
User-Agent: KMail/1.5
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <bnbi95$3qn$1@gatekeeper.tmr.com> <20031024165553.GB933@inwind.it>
In-Reply-To: <20031024165553.GB933@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310280312.20760.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 October 2003 11:55, M. Fioretti wrote:
> On Fri, Oct 24, 2003 15:59:33 at 03:59:33PM +0000, bill davidsen 
(davidsen@tmr.com) wrote:
> > | > If we can ensure that Linux keeps working on these machines, it
> > | > will be a good thing.
> >
> > Agreed, until you start to talk cluster. If you pay for electricity,
> > newer machines use less per MHz. One of those $200 "Lindows" boxen
> > from Wal-Mart starts to look good about the 2nd old Pentium!
>
> May I ask you to elaborate on this? Less per MHz doesn't matter much
> if the frequency is much higher, or it does? I mean, if you put, say,
> a 133 MHz pentium and a 1 GB pentium to do the same thing with the
> same SW (mail server, for example), the 1GB system may use less per
> MHz (newer silicon, lower voltage, etc...) and its flip-flops toggle
> for a smaller percentage of time, but its electricity bill will still
> be the higher one, or not?
>
> In general: has anybody ever done *this* kind of benchmarks? Comparing
> electricity consumption among different systems doing just the same
> task?

Yes.  IBM did.  They were used it as a big arument in favor of linux on the 
mainframe instead of beowulf circa 2000 or so.  (In serious server room 
environments, you have to pay the electricity bill twice.  Once to power the 
systems and once for the air conditioning to remove the heat created by 
powering the systems... :)

Rob


