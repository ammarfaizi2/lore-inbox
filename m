Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSHYK6M>; Sun, 25 Aug 2002 06:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSHYK6L>; Sun, 25 Aug 2002 06:58:11 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:15364 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317215AbSHYK6L>; Sun, 25 Aug 2002 06:58:11 -0400
Date: Sun, 25 Aug 2002 13:01:56 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@redhat.com>,
       Allan Duncan <allan.d@bigpond.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: Linux 2.4.20-pre4-ac1
Message-ID: <20020825110156.GB1107@louise.pinerecords.com>
References: <3D6789CF.B812272F@bigpond.com> <200208241355.g7ODt3c26753@devserv.devel.redhat.com> <20020824140706.GA17957@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020824140706.GA17957@codepoet.org>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 3:20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The message "Warning: Primary channel requires an 80-pin cable for operation"
> > > is (apart from being wrongly asserted as we know) incorrect is detail:
> > > the plugs ARE 40-pin, the cable however is 80 conductor.
> > 
> > True, but I'm not sure a longer less obvious message will help users
> 
> "Warning: Limiting speed since you did not use an 80-conductor cable"

Pronouns should generally be avoided in formulations such as this one,
simply because there's no way to tell who it really was who didn't use
an 80-conductor cable. Go with a passive sentence instead.

T.
