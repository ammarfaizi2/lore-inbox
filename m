Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267975AbTGIARw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 20:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbTGIARw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 20:17:52 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:25348 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267975AbTGIARv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 20:17:51 -0400
Subject: Re: 2.5.74-mm2 [kernel BUG at include/linux/list.h:148!]
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030709001803.GC16488@matchmail.com>
References: <20030705132528.542ac65e.akpm@osdl.org>
	 <1057455650.3119.3.camel@debian> <20030706134926.GA472@nikolas.hn.org>
	 <20030708004350.GA16488@matchmail.com> <1057706251.922.1.camel@debian>
	 <20030709001803.GC16488@matchmail.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1057710738.1003.14.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 09 Jul 2003 02:32:19 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El mi? 09-07-2003 a las 02:18, Mike Fedyk escribió:
> On Wed, Jul 09, 2003 at 01:17:32AM +0200, Ram?n Rey Vicente???? wrote:
> > Call Trace: [<c0116ea0>]  [<c013bb2e>]  [<c013f522>]  [<c011894e>] 
> > [<c011c44d>]
> >   [<c0109a20>]  [<c01097d3>]  [<c0109ab1>]  [<c0118599>]  [<c0130259>] 
> > [<c01621
> > 8e>]  [<c01307f8>]  [<c01091ad>]  [<c0118599>]  [<c0193e05>] 
> > [<c0116f20>]  [<c0
> > 116f20>]  [<c0156924>]  [<c0156dae>]  [<c0157a2a>]  [<c014892c>] 
> > [<c0148db9>]  
> > [<c0108f47>] 
> 
> Now run it through ksymoops.  You should consider using the in kernel oops
> decoding.  Just turn kksymoops on in the debugging menu.

I'm currently doing that :), my pc is not a Sun 10000, so I try to build
the kernel only de necessary. 

Whenever I get the errors, I'll report it inmediately
-- 
/================================================\
| Ramón Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\================================================/

