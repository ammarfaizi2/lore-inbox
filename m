Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261777AbTCaS31>; Mon, 31 Mar 2003 13:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbTCaS31>; Mon, 31 Mar 2003 13:29:27 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:292 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261777AbTCaS30>; Mon, 31 Mar 2003 13:29:26 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303311835.h2VIZXp04133@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.21-pre6
To: fede2@fuerzag.ulatina.ac.cr (Alvaro Figueroa)
Date: Mon, 31 Mar 2003 13:35:33 -0500 (EST)
Cc: alan@redhat.com, marcelo@conectiva.com.br (Marcelo Tosatti),
       linux-kernel@vger.kernel.org
In-Reply-To: <1049134568.27013.7.camel@viena> from "Alvaro Figueroa" at Mar 31, 2003 12:16:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here goes -pre6.
> 
> > Alan Cox <alan@lxorguk.ukuu.org.uk>:
> (...)
> >   o ali5451 is 31bit audio
> 
> Unfortunately, this patch has completely screwed up sound on the Sun
> Blade 100.
> 
> I was wondering if this patch could be backed up in -pre7.

No. Its a bug fix. DaveM is aware of the fact the sparc side needs
some tweaking
