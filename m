Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVEDVkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVEDVkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVEDVhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:37:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:5786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261673AbVEDVgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:36:00 -0400
Date: Wed, 4 May 2005 14:37:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] jfs update
In-Reply-To: <20050504204744.DA0A0849AD@kleikamp.dyn.webahead.ibm.com>
Message-ID: <Pine.LNX.4.58.0505041437060.2328@ppc970.osdl.org>
References: <20050504204744.DA0A0849AD@kleikamp.dyn.webahead.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 May 2005, Dave Kleikamp wrote:
>
> I think I've got this set up right.  I have created a HEAD-for-linus and
> HEAD-for-mm in the same git repo.

Ok, my scripts don't handle that very well yet (they just want HEAD), but 
that was easy enough to hack around. I'll be able to work with that 
format.

> Please pull from
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-linus

Pulled, and pushed out.

		Linus
