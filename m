Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSBYUNy>; Mon, 25 Feb 2002 15:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292586AbSBYUMj>; Mon, 25 Feb 2002 15:12:39 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:16900 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292581AbSBYUMU>; Mon, 25 Feb 2002 15:12:20 -0500
Date: Mon, 25 Feb 2002 16:03:30 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Hugh Dickins <hugh@veritas.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18
In-Reply-To: <Pine.LNX.4.21.0202252007540.7105-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0202251603190.31438-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Hugh Dickins wrote:

> On Mon, 25 Feb 2002, Marcelo Tosatti wrote:
> > 
> > Finally, 2.4.18. No changes between it and -rc4.
> > 
> > final:
> > 
> > - No changes have been made between -final 
> >   and -rc4.
> > 
> > rc4:
> > 
> > - Load code did not set personality for
> >   binaries without an interpreter: This was 
> >   breaking static apps on several archs		(Tom Gall)
> 
> Am I imagining it, or has this -rc4 fix gone missing in final?

Indeed you are right: The fix is missing. 


