Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWGaTUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWGaTUO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWGaTUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:20:14 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55449 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030340AbWGaTUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:20:12 -0400
Message-Id: <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>
To: Adrian Ulrich <reiser4@blinkenlights.ch>
cc: Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
In-Reply-To: Message from Adrian Ulrich <reiser4@blinkenlights.ch> 
   of "Mon, 31 Jul 2006 17:59:58 +0200." <20060731175958.1626513b.reiser4@blinkenlights.ch> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 31 Jul 2006 15:18:52 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 31 Jul 2006 15:18:53 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Ulrich <reiser4@blinkenlights.ch> wrote:

[...]

> ZFS uses 'dnodes'. The dnodes are allocated on demand from your
> available space so running out of [di]nodes is impossible.
> 
> Great to see that Sun ships a state-of-the-art Filesystem with
> Solaris... I think linux should do the same...

This would be worthwhile, if only to be able to futz around in Solaris-made
filesystems.

Are you volunteering? You'd probably need a friend in Solaris-land who
passes you information on how things are done, and copies of filessytems to
take apart, and so on. 

First question is if there are any restrictions (patent or otherwise) on
doing this, just copying is out of the question due to (unfortunate)
licence on Sun's part.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
