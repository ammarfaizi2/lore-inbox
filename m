Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbUKPRvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbUKPRvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUKPRvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:51:39 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:11711 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262077AbUKPRvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:51:02 -0500
To: greg@kroah.com
CC: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20041116170339.GD6264@kroah.com> (message from Greg KH on Tue,
	16 Nov 2004 09:03:39 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com>
Message-Id: <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 18:50:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's an old message, and yes, it's there to scare people away.  Glad to
> see it's working :)

So if I only need a single device number should I register a "misc"
device?  misc_register() seems to create the relevant sysfs entry.

Thanks,
Miklos
