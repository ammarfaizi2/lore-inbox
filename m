Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTKQGQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 01:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTKQGQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 01:16:49 -0500
Received: from f21.mail.ru ([194.67.57.54]:15888 "EHLO f21.mail.ru")
	by vger.kernel.org with ESMTP id S263356AbTKQGQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 01:16:48 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Rusty Russell=?koi8-r?Q?=22=20?= 
	<rusty@rustcorp.com.au>
Cc: =?koi8-r?Q?=22?=Greg KH=?koi8-r?Q?=22=20?= <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: file2alias - incorrect=?koi8-r?Q?=3F=20?=aliases for USB 
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 17 Nov 2003 09:24:22 +0300
In-Reply-To: <20031117060542.489442C266@lists.samba.org>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1ALcoA-0006f7-00.arvidjaar-mail-ru@f21.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Thanks to Andrey for the fix.  Greg, did you want to add something
> else?  Either way, please forward to Linus.
> 

thank you.

> Andrey: the reason everything is in there is I didn't know what Greg
> wanted.  He OK'd it, but I'm happy for them to be trimmed, too.
> 

May I ask reponsible persons - Greg, Rusty - make some decision?
As I have been hammered by Rusty to use modules.alias I am going
to send functions for other subsystems as well - at least USB.
Ironically for all others it makes code much smaller (and possibly
a bit faster). For input it does not bring much :(

regards

-andrey

