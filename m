Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSHILKq>; Fri, 9 Aug 2002 07:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318241AbSHILKq>; Fri, 9 Aug 2002 07:10:46 -0400
Received: from ulima.unil.ch ([130.223.144.143]:59266 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S318240AbSHILKq>;
	Fri, 9 Aug 2002 07:10:46 -0400
Date: Fri, 9 Aug 2002 13:14:26 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: no DMA on 2.4.20-pre1 on ICH4 (2.4.19-rc*-ac* did)
Message-ID: <20020809111426.GI23783@ulima.unil.ch>
References: <20020809090523.GB23783@ulima.unil.ch> <1028889530.30103.192.camel@irongate.swansea.linux.org.uk> <20020809093947.GD23783@ulima.unil.ch> <20020809094302.GB14061@louise.pinerecords.com> <20020809095102.GF23783@ulima.unil.ch> <20020809095229.GC14061@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020809095229.GC14061@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 11:52:29AM +0200, Tomas Szepe wrote:
> > > > (2.4.20-pre1-ac1 didn't compil,
> > > What's the error you're getting?
> > As far as I remember (home computer...) it was apm.c which don't compil
> > on UP (I got a P4). I can do it again tonight ;-)
> 
> Right. That one has been reported before.
> Find the fix in the lkml archives.

Argh, I am really sory, I found it!!!

Thank you very much ;-)

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
