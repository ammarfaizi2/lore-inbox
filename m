Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbSBRVZM>; Mon, 18 Feb 2002 16:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSBRVZD>; Mon, 18 Feb 2002 16:25:03 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45061 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S287631AbSBRVYm>; Mon, 18 Feb 2002 16:24:42 -0500
Date: Mon, 18 Feb 2002 18:15:25 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Barton, Christopher" <cpbarton@uiuc.edu>
Cc: lkml <linux-kernel@vger.kernel.org>, jamal <hadi@cyberus.ca>,
        kuznet@ms2.inr.ac.ru, "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.4.18-pre8
In-Reply-To: <Pine.LNX.4.44.0202181504500.26663-100000@proj2501.aiss.uic.edu>
Message-ID: <Pine.LNX.4.21.0202181815190.25479-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Feb 2002, Barton, Christopher wrote:

> 
> >
> > pre8: 
> > 
> > - Kill get_fast_time				(David S. Miller)
> >
> 
> Is it sufficient to replace get_fast_time with gettimeofday?  This breaks
> the NAPI patch...

Yes. 

