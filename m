Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265228AbUBIOc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 09:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265231AbUBIOc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 09:32:56 -0500
Received: from f23.mail.ru ([194.67.57.149]:62476 "EHLO f23.mail.ru")
	by vger.kernel.org with ESMTP id S265228AbUBIOcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 09:32:55 -0500
From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
To: =?koi8-r?Q?=22?=Ian Kent=?koi8-r?Q?=22=20?= <raven@themaw.net>
Cc: =?koi8-r?Q?=22?=Kernel Mailing List=?koi8-r?Q?=22=20?= 
	<linux-kernel@vger.kernel.org>,
       =?koi8-r?Q?=22?=autofs mailing list=?koi8-r?Q?=22=20?= 
	<autofs@linux.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re[2]: [NFS] nfs or autofs related hangs
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [81.89.69.194]
Date: Mon, 09 Feb 2004 17:32:53 +0300
In-Reply-To: <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= 
	  <ia6432@inbox.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AqCSz-0003v0-00.ia6432-inbox-ru@f23.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Feb 2004 at 23:32:08 +0800 Ian Kent wrote:

> Looking at the trace I can't tell if autofs v4 is causing this but
> I believe there is a potential race in the wait queue code of the
> autofs4 module.
> 
> Could you try this patch please.
ok, i'll test it and let you know.
but it may take up to several days or week...

