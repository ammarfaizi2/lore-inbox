Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316094AbSE3CAT>; Wed, 29 May 2002 22:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316099AbSE3CAS>; Wed, 29 May 2002 22:00:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:18706 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316094AbSE3CAS>; Wed, 29 May 2002 22:00:18 -0400
Date: Wed, 29 May 2002 22:02:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "David S. Miller" <davem@redhat.com>
Cc: lmb@suse.de, <linux-kernel@vger.kernel.org>, <greg@kroah.com>
Subject: Re: Linux 2.4.19-pre9
In-Reply-To: <20020529.182324.44462071.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0205292147320.9982-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 May 2002, David S. Miller wrote:

>    From: Marcelo Tosatti <marcelo@conectiva.com.br>
>    Date: Wed, 29 May 2002 21:34:23 -0300 (BRT)
>
>    > > <davem@nuts.ninka.net> (02/05/06 1.383.11.22)
>    > > 	soft-fp fix:
>
>    David, Greg, and others, please, more readable changelogs :)
>
> I don't understand what people want in that particular kind
> of case.  I made software fp emulation fixes, four of them to
> be precise.  And on the first line I describe in general what
> I'm doing, which is soft-fp bug fixes :-)
>
> I do the same thing for a batch of sparc64 fixes, the first
> line always is the toplevel description:
>
> sparc64 fixes:
>
> which proceeds the actual details:
>
> - Fix signal blah handling
> - Don't bleh during ptrace
> - Disable interrupts around foo
> - Fix IP checksum calculations when bar
>
> Now tell me what is more appropriate on the first line and
> I'll consider it :-)

sparc64 signal/ptrace/foo/net fixes ?

I'm not complaining exactly about _your_ changelogs, but I agree with lmb
that the old format (hand written) was more readable I want help from
everyone to change that.

Just keep in mind that changelog you're writting will be on the official
changelog :)



