Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVBRWgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVBRWgM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 17:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBRWgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 17:36:12 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:16073 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261539AbVBRWgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 17:36:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jvl18IF/WRlPA/EezSGS4yNddIttryU8fcKZF1FDDVSgfS9rw6dVjsKAtdVUIQJXlN3F8mCIxyOlrv+pUKqxb3m307AguYtUqqwal316t4R7pagcWiGjWDqR9rOFW7+eN2NfhjX2PonSpgbFNSiqhjy6sTD8yaZmiDXoSh4th6k=
Message-ID: <d120d500050218143572af23dd@mail.gmail.com>
Date: Fri, 18 Feb 2005 17:35:11 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BK] upgrade will be needed
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, "d.c" <aradorlinux@yahoo.es>,
       "David S. Miller" <davem@davemloft.net>, seanlkml@sympatico.ca,
       tytso@mit.edu, vonbrand@inf.utfsm.cl, cfriesen@nortel.com,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050218221819.GA3864@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <seanlkml@sympatico.ca>
	 <4912.10.10.10.24.1108675441.squirrel@linux1>
	 <200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl>
	 <1451.10.10.10.24.1108713140.squirrel@linux1>
	 <20050218162729.GA5839@thunk.org>
	 <4075.10.10.10.24.1108751663.squirrel@linux1>
	 <20050218214555.1f71c2e4.aradorlinux@yahoo.es>
	 <20050218131326.650c77ad.davem@davemloft.net>
	 <Pine.LNX.4.60.0502182133490.30371@hermes-1.csi.cam.ac.uk>
	 <20050218221819.GA3864@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 23:18:19 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Feb 18, 2005 at 09:34:47PM +0000, Anton Altaparmakov wrote:
> > On Fri, 18 Feb 2005, David S. Miller wrote:
> > > On Fri, 18 Feb 2005 21:45:55 +0100
> > > "d.c" <aradorlinux@yahoo.es> wrote:
> > >
> > > > 2) And more important, *nobody* works against "linus' bk head".
> > >
> > > I do, %100 exclusively, for all the networking and sparc
> > > development.
> > >
> > > I never work against the -mm tree.
> >
> > Dito.  All my kernel development happens against Linus' bk head and I
> > almost never work against -mm tree.
> 
> Same here, I work on Linus's bk head and all the changes go to -mm for
> testing first, then to Linus for inclusion.
> 

I guess there is a perception that developers/maintainers are working
against -mm because all maintainers trees are automatically pulled by
Andrew. And when someone doing stuff on somewhat regular basis he/she
tends to do it against maintainer's tree thus making patches suitable
for -mm as well.
 
-- 
Dmitry
