Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbQL1OTY>; Thu, 28 Dec 2000 09:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130063AbQL1OTE>; Thu, 28 Dec 2000 09:19:04 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:64272 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130061AbQL1OS4>; Thu, 28 Dec 2000 09:18:56 -0500
Date: Thu, 28 Dec 2000 09:56:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: chris@freedom2surf.net
cc: linux-kernel@vger.kernel.org
Subject: Re: Repeatable Oops in 2.4t13p4ac2
In-Reply-To: <978009656.3a4b3e38c7455@www.freedom2surf.net>
Message-ID: <Pine.LNX.4.21.0012280955310.11471-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Dec 2000 chris@freedom2surf.net wrote:

> Hi - we are seeing the following repeatable Oops in 2.4t13p4ac2 compiled using 
> gcc 2.95.2 for PIII running on IDE disks. Occurs whilst copying lots of files 
> to/from remote filesystems.
> 
> Thank you
> 
> Chris
> 
> Unable to handle kernel paging request at virtual address 00040000

Just to confirm: it always oopses on virtual address 00040000 ? 

Thanks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
