Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289481AbSAVWOV>; Tue, 22 Jan 2002 17:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289482AbSAVWOL>; Tue, 22 Jan 2002 17:14:11 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:18442 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289481AbSAVWOG>; Tue, 22 Jan 2002 17:14:06 -0500
Date: Tue, 22 Jan 2002 19:03:04 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Russell King <rmk@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.4.18-pre6
In-Reply-To: <20020122220046.C21383@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.21.0201221902250.2262-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Jan 2002, Russell King wrote:

> On Tue, Jan 22, 2002 at 04:06:38PM -0200, Marcelo Tosatti wrote:
> > pre6:
> > 
> > - Removed patch in icmp code: its not needed 
> >   and causes problems				(me)
> 
> Can you enlighten us as to why it is "not needed" ?  I haven't seen any
> followups from Andi nor Davem to saying that.

David told me the patch is not needed and only 2.2.x and 2.4.0-pre are
affected.

 David? 

