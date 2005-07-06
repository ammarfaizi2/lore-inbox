Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVGFTw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVGFTw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVGFTuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:50:23 -0400
Received: from mail11.bluewin.ch ([195.186.18.61]:53214 "EHLO
	mail11.bluewin.ch") by vger.kernel.org with ESMTP id S262304AbVGFO75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:59:57 -0400
Date: Wed, 6 Jul 2005 16:55:29 +0200
From: Adrian Ulrich <reiser4@blinkenlights.ch>
To: David Masover <ninja@slaphack.com>
Cc: reiser@namesys.com, hubert@uhoreg.ca, agmsmith@rogers.com,
       ross.biro@gmail.com, vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com,
       Valdis.Kletnieks@vt.edu, ltd@cisco.com, gmaxwell@gmail.com,
       jgarzik@pobox.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
Message-Id: <20050706165529.1f0503d5.reiser4@blinkenlights.ch>
In-Reply-To: <42CBE67D.9000507@slaphack.com>
References: <42CB1E12.2090005@namesys.com>
	<1740726161-BeMail@cr593174-a>
	<87hdf8zqca.fsf@evinrude.uhoreg.ca>
	<42CB7DE0.4050200@namesys.com>
	<42CBD7F6.2050203@slaphack.com>
	<20050706154349.5d6aa92c.reiser4@blinkenlights.ch>
	<42CBE67D.9000507@slaphack.com>
Organization: Bluewin AG
X-Mailer: Sylpheed version 2.0.0beta2 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> mount --bind /meta/vfs/some/chroot /some/chroot/meta

This maybe funny if you got 1-2 chrooted applications.
But it will be a nightmare if you got 20-30 chrooted applications.



-- 
 We're working on it, slowly but surely...or not-so-surely in the spots
we're not so sure... -- Larry Wall
