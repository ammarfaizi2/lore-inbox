Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSHIJtB>; Fri, 9 Aug 2002 05:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318220AbSHIJtA>; Fri, 9 Aug 2002 05:49:00 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:2316 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318219AbSHIJtA>; Fri, 9 Aug 2002 05:49:00 -0400
Date: Fri, 9 Aug 2002 11:52:29 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: no DMA on 2.4.20-pre1 on ICH4 (2.4.19-rc*-ac* did)
Message-ID: <20020809095229.GC14061@louise.pinerecords.com>
References: <20020809090523.GB23783@ulima.unil.ch> <1028889530.30103.192.camel@irongate.swansea.linux.org.uk> <20020809093947.GD23783@ulima.unil.ch> <20020809094302.GB14061@louise.pinerecords.com> <20020809095102.GF23783@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020809095102.GF23783@ulima.unil.ch>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 66 days, 9 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > (2.4.20-pre1-ac1 didn't compil,
> > What's the error you're getting?
> As far as I remember (home computer...) it was apm.c which don't compil
> on UP (I got a P4). I can do it again tonight ;-)

Right. That one has been reported before.
Find the fix in the lkml archives.
