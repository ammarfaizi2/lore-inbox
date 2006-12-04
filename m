Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936866AbWLDN42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936866AbWLDN42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 08:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936867AbWLDN42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 08:56:28 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36480 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S936866AbWLDN41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 08:56:27 -0500
X-Sasl-enc: YOckNb6ERZG7uqRPEOnPJX1QcF1A7+FOc69kDanqDfxO 1165240587
Date: Mon, 4 Dec 2006 11:56:11 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061204135611.GA18520@khazad-dum.debian.net>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611190930370.3692@woody.osdl.org> <m3ac2nt7o8.fsf@zoo.weinigel.se> <87041D5C-ECA9-494A-8210-93646FDEA943@mac.com> <20061204105031.GA10976@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204105031.GA10976@elf.ucw.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2006, Pavel Machek wrote:
> On Sun 2006-12-03 16:40:04, Kyle Moffett wrote:
> > On Nov 19, 2006, at 17:04:23, Christer Weinigel wrote:
> > >With suspend-to-disk I can remove the battery (to put in a fresh  
> > >battery when traveling), try doing that with suspend-to-ram.
> > 
> > My PowerBook can do this with suspend-to-ram too; it has an internal  
> > capacitor or battery of some sort which charges in a few minutes and  
> > holds enough power to keep the RAM alive for around a minute while I  
> > swap batteries.
> 
> Well.. OTOH your powerbook is probably the _only_ machine that can do
> that :-).

Well, most ThinkPads can do that if you stick a secondary bay battery into
it, but I feel the powerbook solution is a lot more elegant :)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
