Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267205AbTGLAry (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267260AbTGLArx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:47:53 -0400
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([66.93.172.17]:29333
	"EHLO nevyn.them.org") by vger.kernel.org with ESMTP
	id S267205AbTGLArv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:47:51 -0400
Date: Fri, 11 Jul 2003 21:02:32 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc-3.3.1 breaks kernel
Message-ID: <20030712010232.GA7107@nevyn.them.org>
Mail-Followup-To: "J.A. Magallon" <jamagallon@able.es>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <8avk.6lp.3@gated-at.bofh.it> <3F0F4C10.9050204@g-house.de> <20030712004301.GE2791@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712004301.GE2791@werewolf.able.es>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 02:43:01AM +0200, J.A. Magallon wrote:
> 
> On 07.12, Christian Kujau wrote:
> > J.A. Magallon wrote:
> > > Hi all...
> > > 
> > > Any brave soul there is using a prerelease of gcc-3.3.1 to build kernels ?
> > > (don't know if RawHide or SuSE beta or any other have that, apart from
> > > MandrakeCooker).
> > 
> > yes, 2.4.2x and 2.5.7x build properly with Debians gcc-3.3.1 here (x86).
> > 
> 
> Plz, can you tell me the exact version of gcc (date of snapshot or the
> like). My cooker gcc is:
> 
> - Update to 3.3-hammer branch as of 2003/07/03
> 
> Perhaps I can dig the gcc changelogs to look for something.
> 
> This is really strange...

Then ask your vendor about that, it's not the 3.3 branch.  Hammer is
maintained by (I think) SuSE people.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
