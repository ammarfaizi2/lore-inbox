Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270622AbTGNNHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270615AbTGNNA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:00:29 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:49657 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S270597AbTGNNAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:00:01 -0400
Subject: Re: gcc-3.3.1 breaks kernel
From: Martin Schlemmer <azarah@gentoo.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Christian Kujau <evil@g-house.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030712004301.GE2791@werewolf.able.es>
References: <8avk.6lp.3@gated-at.bofh.it> <3F0F4C10.9050204@g-house.de>
	 <20030712004301.GE2791@werewolf.able.es>
Content-Type: text/plain
Organization: 
Message-Id: <1058188482.1164.352.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 14 Jul 2003 15:14:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-12 at 02:43, J.A. Magallon wrote:
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

This is known to break many things for x86 (p3/4 as well as athlon).
I have not checked it in some time, so not sure if all the issues
we had was fixed.  Rather stip the hammer stuff.


Cheers,

-- 
Martin Schlemmer


