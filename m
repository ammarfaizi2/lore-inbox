Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWGaWJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWGaWJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWGaWJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:09:20 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:28594 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751349AbWGaWJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:09:19 -0400
Message-Id: <200607312208.k6VM82P5012867@laptop13.inf.utfsm.cl>
To: Adrian Ulrich <reiser4@blinkenlights.ch>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, matthias.andree@gmx.de,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion] 
In-Reply-To: Message from Adrian Ulrich <reiser4@blinkenlights.ch> 
   of "Mon, 31 Jul 2006 22:57:34 +0200." <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 31 Jul 2006 18:08:02 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 31 Jul 2006 18:08:08 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Ulrich <reiser4@blinkenlights.ch> wrote:
> > > Great to see that Sun ships a state-of-the-art Filesystem with
> > > Solaris... I think linux should do the same...
> > 
> > This would be worthwhile, if only to be able to futz around in Solaris-made
> > filesystems.

> s/I think linux should do the same/I think linux should include Reiser4/
>  ;-)

So ZFS isn't "state-of-the-art"?

[...]

> But i'd rather like to see a Linux version of WAFL :-)

WAFL is for high-turnover filesystems on RAID-5 (and assumes flash memory
staging areas). Not your run-of-the-mill desktop...

> ZFS didn't really impress me: 
> The Volume-Manager is nice but the Filesystem.. well: It beats UFS
> .. sometimes ;-)

OK, ext3 + LVM it is then.

> See also: http://spam.workaround.ch/dull/postmark.txt

Interesting.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
