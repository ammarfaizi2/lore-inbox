Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287769AbSASWe7>; Sat, 19 Jan 2002 17:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287748AbSASWet>; Sat, 19 Jan 2002 17:34:49 -0500
Received: from pa160.grajewo.sdi.tpnet.pl ([217.96.134.160]:64386 "HELO
	pa160.grajewo.sdi.tpnet.pl") by vger.kernel.org with SMTP
	id <S287743AbSASWeg>; Sat, 19 Jan 2002 17:34:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Gniazdowski <refuse7@poczta.fm>
Reply-To: refuse7@poczta.fm
Organization: none
To: "Martin Eriksson" <nitrax@giron.wox.org>
Subject: Re: reiserFS undeletion
Date: Sat, 19 Jan 2002 23:45:04 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020119121610.DD9D02B5D9@pa160.grajewo.sdi.tpnet.pl> <20020119172934.4240F2B5D9@pa160.grajewo.sdi.tpnet.pl> <001301c1a11a$79884580$0201a8c0@HOMER>
In-Reply-To: <001301c1a11a$79884580$0201a8c0@HOMER>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020119224504.6470F2BB61@pa160.grajewo.sdi.tpnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

19 Jan 2002 19:52, Martin Eriksson wrote:
> > 19 Jan 2002 17:41, Hans Reiser wrote:
> > > we only log metadata.
> >
> > I know. Butt if i delete some file, it dosnt mean i set zero on sectors
> > on disk. So imvho all is needet is meta data.
>
> Yes, but (not butt =) if you have done some other file operations after the
> delete, your deleted file might have been overwritten by another file.
> Especially if you have little free space on your hard disk.

Yep but ( ;)  80% situations is like "ups i deleted it" and undeletion 
operation is taken straight after that. So it would be nice to have it... 
Just a sugestion...

Regards Gniazdowski.
