Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbTAUOoN>; Tue, 21 Jan 2003 09:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTAUOoN>; Tue, 21 Jan 2003 09:44:13 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:13691 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S267094AbTAUOoN>; Tue, 21 Jan 2003 09:44:13 -0500
Message-Id: <5.2.0.9.0.20030121155241.02be03c0@oceanic.wsisiz.edu.pl>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 21 Jan 2003 15:54:49 +0100
To: "Stephen C. Tweedie" <sct@redhat.com>
From: Bartlomiej Solarz-Niesluchowski 
	<B.Solarz-Niesluchowski@wsisiz.edu.pl>
Subject: Re: 2.4.21-pre3 - problems with ext3 (long)
Cc: Lukasz Trabinski <lukasz@wsisiz.edu.pl>, akpm@zip.com.au,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1043159893.2424.59.camel@sisko.scot.redhat.com>
References: <5.2.0.9.0.20030121152101.02c1e740@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.51.0301210029010.30053@oceanic.wsisiz.edu.pl>
 <Pine.LNX.4.51.0301141401260.6636@oceanic.wsisiz.edu.pl>
 <1043102297.13050.59.camel@sisko.scot.redhat.com>
 <Pine.LNX.4.51.0301210029010.30053@oceanic.wsisiz.edu.pl>
 <5.2.0.9.0.20030121152101.02c1e740@oceanic.wsisiz.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:38 2003-01-21 +0000, Stephen C. Tweedie wrote:
>Hi,
>
>On Tue, 2003-01-21 at 14:22, Bartlomiej Solarz-Niesluchowski wrote:
> > At 13:56 2003-01-21 +0000, Stephen C. Tweedie wrote:
> >
> > >If that happens again, serial console is the best way of getting the
> > >full oops.  How much memory does your system have?  Have you ever seen
> > >this error before?
> >
> > Yes - we have seen this error before.....
>
>Well, the kmap() bug looks like kunmap() being done twice on a page.  If
>that's happening, we really do need to find out where, so capturing that
>trace via serial console would be a _big_ help, thanks.

OK I make serial console especially for this.... - see you soon (I think 
that my system will have crash about tomorrow (est. uptime now is about 3-4 
days)).....


--
Bartlomiej Solarz-Niesluchowski, Administrator WSISiZ
e-mail: B.Solarz-Niesluchowski@wsisiz.edu.pl

