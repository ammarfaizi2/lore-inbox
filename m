Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVC1TMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVC1TMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVC1TMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:12:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:51598 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261992AbVC1TMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:12:20 -0500
Date: Mon, 28 Mar 2005 11:11:31 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: chas3@users.sourceforge.net, bridge@osdl.org,
       linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix bridge <-> ATM compile error
Message-ID: <20050328111131.2f511a85@dxpl.pdx.osdl.net>
In-Reply-To: <20050319230458.GB18495@stusta.de>
References: <20050316181532.GA3251@stusta.de>
	<200503172036.j2HKadfm000732@ginger.cmf.nrl.navy.mil>
	<20050319230458.GB18495@stusta.de>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005 00:04:58 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Thu, Mar 17, 2005 at 03:36:40PM -0500, chas williams - CONTRACTOR wrote:
> > In message <20050316181532.GA3251@stusta.de>,Adrian Bunk writes:
> > >Letting CONFIG_BRIDGE depend on CONFIG_ATM doesn't sound like a good 
> > >idea, since I doubt all people using the Bridge code require ATM 
> > >support.
> > 
> > how about the following?
> >...
> 
> Looks good

Ditto
