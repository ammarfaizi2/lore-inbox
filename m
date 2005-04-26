Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVDZKBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVDZKBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVDZJ5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:57:33 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:41375 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261453AbVDZJxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:53:39 -0400
To: hch@infradead.org
CC: miklos@szeredi.hu, hch@infradead.org, jamie@shareable.org,
       linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050426094727.GA30379@infradead.org> (message from Christoph
	Hellwig on Tue, 26 Apr 2005 10:47:27 +0100)
Subject: Re: [PATCH] private mounts
References: <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org>
Message-Id: <E1DQMkX-0000Fy-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Apr 2005 11:53:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Christoph, you are being thickheaded, and this is not the first time.
> > Please go away.
> 
> Please stop the flaming.  You're adding the equivalent of "I've added
> a suid shell, please make sure it can only affect the caller's files".
> 
> Do you really think we want to add such crap?

Do you think I'd want such crap?

No. FUSE is not a suid shell, and it's definitely not crap.  You are
being impolite and without a reason.  So don't be surprised if you get
burned.

> You're really falling into the Hans Reiser trap - if you just wanted to
> add a simple userland filesystem you'd be done by now, but you're trying
> to funnel new semantics in through it.  Which is by far not as easy as
> adding a simple file system driver and needs a lot more though.  

I've started FUSE in 2001.  Did you think it was easy getting this far?

Come on!

Miklos
