Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUA0GNs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 01:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUA0GNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 01:13:48 -0500
Received: from mail.bluebottle.com ([69.20.6.25]:55430 "EHLO
	www.bluebottle.com") by vger.kernel.org with ESMTP id S262730AbUA0GNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 01:13:46 -0500
Date: Tue, 27 Jan 2004 04:13:43 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: [uPATCH] ufs.txt update
In-Reply-To: <81ektm9dvh.wl@omega.webmasters.gr.jp>
Message-ID: <Pine.LNX.4.58.0401270409450.949@pervalidus.dyndns.org>
References: <UTC200401250035.i0P0ZJW13717.aeb@smtp.cwi.nl>
 <87u12ksac2.fsf@echidna.jochen.org> <81ektm9dvh.wl@omega.webmasters.gr.jp>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004, GOTO Masanori wrote:

> At Sun, 25 Jan 2004 09:26:21 +0100,
> Jochen Hein wrote:
> > Andries.Brouwer@cwi.nl writes:
> >
> > >  	old	old format of ufs
> > > -		default value, supported os read-only
> > > +		supported os read-only
> >
> > s/os/as/ ?
> >
> > >  	44bsd	used in FreeBSD, NetBSD, OpenBSD
> > >  		supported os read-write
> >
> > s/os/as/ ?
>
> Exactly.  In addition I think removing "default value" from "old"
> entry is no effectiveness, so I revive this sentence.
>
> This patch updates typos and HP-UX description in
> Documentation/filesystems/ufs.txt, suggested by Andries.Brouwer@cwi.nl
> and Jochen Hein <jochen@jochen.org>.

Someone could also add some notes to ufs.txt and the Configure
entry for 2.4 and 2.6 about the lack of UFS2 support, which is
the default since FreeBSD 5.1.

-- 
http://www.pervalidus.net/contact.html
