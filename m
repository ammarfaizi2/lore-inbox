Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbTHTSLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTHTSLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:11:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:1160 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262122AbTHTSLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:11:54 -0400
Date: Wed, 20 Aug 2003 11:07:42 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: root@mauve.demon.co.uk, tmolina@cablespeed.com,
       linux-kernel@vger.kernel.org, greg@kroah.com, zwane@linuxpower.ca
Subject: Re: Console on USB
Message-Id: <20030820110742.0cd0160a.rddunlap@osdl.org>
In-Reply-To: <200308201756.h7KHuJuu012039@turing-police.cc.vt.edu>
References: <200308201745.SAA23241@mauve.demon.co.uk>
	<200308201756.h7KHuJuu012039@turing-police.cc.vt.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003 13:56:18 -0400 Valdis.Kletnieks@vt.edu wrote:

| On Wed, 20 Aug 2003 18:44:58 BST, root@mauve.demon.co.uk said:
| 
| > For laptops, might console=/dev/irda work?
| 
| Hmm.... <looks around>  Do I have anything handy that will *catch* stuff being
| spewed out the irda port?  Don't think so, or I'd have built that driver....
| 
| Yes, might work, *if* you have hardware handy.

I don't see any console support in the irda drivers...
How is it supposed to work?
or do you just mean that in theory it could be made to work?

--
~Randy   [MOTD:  Always include kernel version.]
"Everything is relative."
