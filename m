Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbSI2QKm>; Sun, 29 Sep 2002 12:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262793AbSI2QKm>; Sun, 29 Sep 2002 12:10:42 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:2291 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262790AbSI2QKm>; Sun, 29 Sep 2002 12:10:42 -0400
Subject: Re: v2.6 vs v3.0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020929154254.GD1014@suse.de>
References: <200209290114.15994.jdickens@ameritech.net>
	<Pine.LNX.4.44.0209290858170.22404-100000@innerfire.net>
	<20020929134620.GD2153@gallifrey>  <20020929154254.GD1014@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 17:21:49 +0100
Message-Id: <1033316509.13001.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 16:42, Jens Axboe wrote:
> Has anyone actually sent patches to Linus removing LVM completely from
> 2.5 and adding the LVM2 device mapper? If I used LVM, I would have done
> exactly that long ago. Linus, what's your oppinion on this?

I added LVM2 a while ago for my 2.4-ac tree and haven't looked back, its
much nicer code and its clean and easy to understand. I wouldnt
guarantee its bug free but its the kind of code where you can *find* a
bug if one turns up

