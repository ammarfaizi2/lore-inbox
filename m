Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTLJCsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTLJCsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:48:52 -0500
Received: from imap.gmx.net ([213.165.64.20]:40324 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263453AbTLJCsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:48:51 -0500
Date: Wed, 10 Dec 2003 03:48:50 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20031210004120.GB2196@kroah.com>
Subject: Re: Badness in kobject_get at lib/kobject.c:439
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <4932.1071024530@www43.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 10, 2003 at 01:36:25AM +0100, Svetoslav Slavtchev wrote:
> > 
> > the attached oops couldn't happen in vanilla kernel ?
> > or should i try without the ruby patches ?
> 
> Can you try it without the ruby patches?  I have no idea what is
> contained in them.
> 

may be i should stop seti@home, but the kernel is compiling without them :-)

the ruby patch adds a multi-user console support,
and changes a lot of stiff in the vt subsystem

will report when i have results

best,

svetljo

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


