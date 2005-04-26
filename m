Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVDZKJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVDZKJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVDZKI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:08:58 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:47775 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261439AbVDZKBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:01:52 -0400
To: hch@infradead.org
CC: miklos@szeredi.hu, hch@infradead.org, jamie@shareable.org,
       linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-reply-to: <20050426095608.GA30554@infradead.org> (message from Christoph
	Hellwig on Tue, 26 Apr 2005 10:56:08 +0100)
Subject: Re: [PATCH] private mounts
References: <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <E1DQMkX-0000Fy-00@dorka.pomaz.szeredi.hu> <20050426095608.GA30554@infradead.org>
Message-Id: <E1DQMsX-0000IX-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Apr 2005 12:01:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > No. FUSE is not a suid shell, and it's definitely not crap.  You are
> > being impolite and without a reason.  So don't be surprised if you get
> > burned.
> 
> You're model for user mounts is total crap.  The rest of the fuse kernel
> code is quite nice (1).

Oh, a compliment from Christoph H. himself, how flattering :)

And for the first part, please _explain_ why you think it's crap.
Calling something crap, will surely not make it less crap, will it?

Miklos
