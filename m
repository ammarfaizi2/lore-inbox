Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUBIPng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 10:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbUBIPng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 10:43:36 -0500
Received: from f22.mail.ru ([194.67.57.55]:8209 "EHLO f22.mail.ru")
	by vger.kernel.org with ESMTP id S262126AbUBIPnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 10:43:35 -0500
From: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
To: =?koi8-r?Q?=22?=Ian Kent=?koi8-r?Q?=22=20?= <raven@themaw.net>
Cc: =?koi8-r?Q?=22?=Kernel Mailing List=?koi8-r?Q?=22=20?= 
	<linux-kernel@vger.kernel.org>,
       =?koi8-r?Q?=22?=autofs mailing list=?koi8-r?Q?=22=20?= 
	<autofs@linux.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re[3]: [NFS] nfs or autofs related hangs
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [81.89.69.194]
Date: Mon, 09 Feb 2004 18:43:34 +0300
In-Reply-To: <Pine.LNX.4.58.0402092314180.5821@raven.themaw.net>
Reply-To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= 
	  <ia6432@inbox.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AqDZO-000G5Z-00.ia6432-inbox-ru@f22.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004 at 23:21:12 +0800 Ian Kent wrote:

> > > Could you try this patch please.
> > ok, i'll test it and let you know.
> > but it may take up to several days or week...
> 
> No problem.
> 
> The patch is against my 20031201 autofs4.
> If you wish to test against a vanila kernel I'll need to revise it.
i'll test this patch with our 2.4.23aa1 + autofs4-20031201 and
2.4.25-rc1 + autofs4-20031201 (should it work?)...

