Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbTA3KxV>; Thu, 30 Jan 2003 05:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267480AbTA3KxV>; Thu, 30 Jan 2003 05:53:21 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:46984 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267463AbTA3KxU> convert rfc822-to-8bit; Thu, 30 Jan 2003 05:53:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>
Subject: Re: sys_sendfile64 not in Linux 2.4.21-pre4
Date: Thu, 30 Jan 2003 12:02:01 +0100
User-Agent: KMail/1.4.3
Cc: John Fremlin <vii@users.sourceforge.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, cw@f00f.org, bcrl@redhat.com
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva> <20030130082922.A22879@infradead.org> <1043926388.28133.16.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1043926388.28133.16.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301301202.01897.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 January 2003 12:33, Alan Cox wrote:

> On Thu, 2003-01-30 at 08:29, Christoph Hellwig wrote:
> > On Thu, Jan 30, 2003 at 12:47:14AM +0000, John Fremlin wrote:
> > > Why isn't sendfile64 included in 2.4.21-pre4? glibc 2.3 already
> > > expects it, so programs with 64-bit off_t will not be able to use
> > > sendfile otherwise. And the patch is IIUC very small . . .
> >
> > I sent patches to Marcelo a few times, but they got silently ignored..
>
> Can you forward me a copy ?
to me too please :)

ciao, Marc
