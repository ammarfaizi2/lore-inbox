Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262478AbUKQSSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbUKQSSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUKQSSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:18:00 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:22416 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262478AbUKQSRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:17:32 -0500
To: greg@kroah.com
CC: nikita@clusterfs.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20041117181105.GA28821@kroah.com> (message from Greg KH on Wed,
	17 Nov 2004 10:11:05 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu> <16795.33515.187015.492860@thebsh.namesys.com> <E1CUU2P-0005g4-00@dorka.pomaz.szeredi.hu> <20041117181105.GA28821@kroah.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <E1CUUMv-0005kz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Nov 2004 19:17:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Think about putting the /sys/sysfs entry into the tree before sysfs has
> been fully initialized :)

I'd rather not think about it.  It reminds me of Gödel's paradox...

> Look through the 2.5 kernel series, it was in there for a while.
> 
> But don't really worry about it, just create /sys/fs/ and use it to put
> your own stuff in it if you want.  Don't try to recreate the old, buggy
> stuff :)

OK.

Thanks,
Miklos
