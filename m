Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282092AbRLQSu2>; Mon, 17 Dec 2001 13:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282129AbRLQSuS>; Mon, 17 Dec 2001 13:50:18 -0500
Received: from relay02.cablecom.net ([62.2.33.102]:53517 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S282092AbRLQSt6>; Mon, 17 Dec 2001 13:49:58 -0500
Message-ID: <3C1E3E4D.FFCAC861@bluewin.ch>
Date: Mon, 17 Dec 2001 19:49:49 +0100
From: Otto Wyss <otto.wyss@bluewin.ch>
Reply-To: otto.wyss@bluewin.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <Pine.GSO.4.21.0112161542420.937-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well a simple solution would be if Linux supports the multiple streams file
> > format. 
> 
> "Forked files" crap _is_ known.  And not welcome.
> 
> There is a bog-standard way to combine several files in one - cpio.  Or tar.
> No need to bring Apple Shit-For-Design(tm)(r) when standard tools are quite
> enough.
>
I don't want to bring in any ...-Design if standard tools are enough! If
cpio/tar do suffice, then much better. I don't know if they are simple and
fitting enough to be handled by any boot loader and the kernel. Maybe you could
elaborate more on this.

You have to admit that a multiple streams file format (regardless which kind)
would be a good solution to the booting of a modular kernel. Anyway this format
has to be supported by the kernel itself and in some extend by any boot loader.
So anybody has to write a kernel module for the cpio/tar format and help with
implementing it into  boot loaders. Maybe you could give some help. 


O. Wyss
