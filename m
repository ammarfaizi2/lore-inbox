Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVD0RtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVD0RtA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVD0Rs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:48:56 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:28837 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261857AbVD0Rr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:47:57 -0400
To: linuxram@us.ibm.com
CC: lmb@suse.de, mj@ucw.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1114623598.4480.181.camel@localhost> (message from Ram on Wed,
	27 Apr 2005 10:39:59 -0700)
Subject: Re: [PATCH] private mounts
References: <20050426094727.GA30379@infradead.org>
	 <20050426131943.GC2226@openzaurus.ucw.cz>
	 <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
	 <20050426201411.GA20109@elf.ucw.cz>
	 <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu>
	 <20050427092450.GB1819@elf.ucw.cz>
	 <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu>
	 <20050427143126.GB1957@mail.shareable.org>
	 <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu>
	 <20050427153320.GA19065@atrey.karlin.mff.cuni.cz>
	 <20050427155022.GR4431@marowsky-bree.de>
	 <E1DQqQ0-0002PB-00@dorka.pomaz.szeredi.hu> <1114623598.4480.181.camel@localhost>
Message-Id: <E1DQqdW-0002SN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 19:47:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you need to disallow overmounts on invisible mounts by any user
> other than the owner. If not, some other user (including root) can
> overmount on your mount and the user will end up with DoS.

I'm not following you here.  How would an overmount cause DoS?

Thanks,
Miklos
