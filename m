Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVALUfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVALUfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVALUfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:35:40 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:19844 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261438AbVALUdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:33:10 -0500
To: vincenzo_mlRE.MOVE@yahoo.it
CC: fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-reply-to: <200501122120.08217.vincenzo_mlRE.MOVE@yahoo.it> (message from
	Vincenzo Ciancia on Wed, 12 Jan 2005 21:20:08 +0100)
Subject: Re: [fuse-devel] Merging?
References: <loom.20041231T155940-548@post.gmane.org> <20050112153131.1f778264.diegocg@gmail.com> <E1CojqJ-0001Mw-00@dorka.pomaz.szeredi.hu> <200501122120.08217.vincenzo_mlRE.MOVE@yahoo.it>
Message-Id: <E1CopAj-0002dC-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 12 Jan 2005 21:32:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps a little heavyweight but it would solve an outstanding problem 
> which is "I have the software, I have the hardware, hell, why should I 
> type my root password to mount a ****ing iso ?" :)

Exactly!

In fact it's not so heavyweight either.  A standalone UML binary which
just contains all the major filesystems and the core kernel is little
over 3Mbytes.  It's smaller than many binaries even without their
library dependencies.  It loads in less than a second...  The linux
kernel is still pretty nice and lean!

Miklos
