Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130524AbQL1RAY>; Thu, 28 Dec 2000 12:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130582AbQL1RAP>; Thu, 28 Dec 2000 12:00:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:4625 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130524AbQL1RAB>; Thu, 28 Dec 2000 12:00:01 -0500
Date: Thu, 28 Dec 2000 12:36:55 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: chris@freedom2surf.net, linux-kernel@vger.kernel.org
Subject: Re: Repeatable Oops in 2.4t13p4ac2
In-Reply-To: <E14BfI7-0003qn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012281236060.12295-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Dec 2000, Alan Cox wrote:

> > Hi - we are seeing the following repeatable Oops in 2.4t13p4ac2 compiled using 
> > gcc 2.95.2 for PIII running on IDE disks. Occurs whilst copying lots of files 
> > to/from remote filesystems.
> 
> I've had a couple of reports like this. Can you test 2.4t13p4 without the -ac
> changes. If the -ac changes cause it then I need to know, but with the -ac
> changes nobody else will care ;)
> 
> So the first way to narrow it down is that

Alan, 

Do you remember if the reports you've got always oopsed the same
address (0040000) ? 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
