Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283188AbRLDPPk>; Tue, 4 Dec 2001 10:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283204AbRLDPOm>; Tue, 4 Dec 2001 10:14:42 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:8968 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S283064AbRLDPMz>; Tue, 4 Dec 2001 10:12:55 -0500
Date: Tue, 4 Dec 2001 11:56:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: petter wahlman <pwa@norman.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-pre2 missing ymfpci updates
In-Reply-To: <1007463970.2776.2.camel@lunix>
Message-ID: <Pine.LNX.4.21.0112041150250.19552-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, sorry about that...

I'm still getting used to maintain all of the patches.

I'm setting up an internal CVS to avoid making those mistakes again...

On 4 Dec 2001, petter wahlman wrote:

> According to the changelog there should be some changes to the
> ymfpci driver. This does not seem to be the case:
> 
> [97%](petter):patches>egrep -i 'ymf|Zaitcev' patch-2.4.17-pre2
> [97%](petter):patches>
> 
> from changelog:
> ...
> - ymfpci driver cleanup 			(Pete Zaitcev)
> ...
> 
> 
> btw: I'm not subscribed to this list.
> 
> 
> Petter Wahlman
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

