Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVDZN3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVDZN3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 09:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVDZN3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 09:29:24 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:31648 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261487AbVDZN3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 09:29:21 -0400
To: pavel@ucw.cz
CC: hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050426131943.GC2226@openzaurus.ucw.cz> (message from Pavel
	Machek on Tue, 26 Apr 2005 15:19:44 +0200)
Subject: Re: [PATCH] private mounts
References: <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz>
Message-Id: <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Apr 2005 15:28:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we get root-only fuse in, please?

chmod u-s /usr/bin/fusermount

Miklos
