Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290285AbSBKUIw>; Mon, 11 Feb 2002 15:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290297AbSBKUIn>; Mon, 11 Feb 2002 15:08:43 -0500
Received: from pop.gmx.net ([213.165.64.20]:48769 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S290285AbSBKUId>;
	Mon, 11 Feb 2002 15:08:33 -0500
Message-ID: <041a01c1b337$ee407760$4000a8c0@angband>
Reply-To: "Andreas Happe" <andreashappe@subdimension.com>
From: "Andreas Happe" <andreashappe@gmx.net>
To: "lkml" <linux-kernel@vger.kernel.org>, "Oleg Drokin" <green@namesys.com>
In-Reply-To: <000c01c1b0bf$567ab910$704e2e3e@angband> <20020208180216.H32413@suse.de> <00c301c1b0d7$d1f07ae0$4e492e3e@angband> <20020211160658.A7863@namesys.com>
Subject: Re: boot problems using 2.5.3-dj3 || -dj4
Date: Mon, 11 Feb 2002 21:05:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[...]
> > the error occurs in  ./fs/reiserfs/tail-conversion.c .
> > the kernel oops jumped to another position by now, but it is still the
same
> > error message. I'm using a reiserfs root position.
> Can you please decode the oops you provided.
> Also can you run reiserfsck on your partition and give us the log file?
> Thank you. (you may need to boot off rescue CD or something to
> be able to run reiserfsck on root partition).
>

i've done this yesterday and there were a couple of errors (i rebuilt the
tree and tried to rebuild the sb). Due to an error at rebuilding the super
block, I reinstalled my linux system ( i'm not sure if this is related to my
actual kernel, btw. there were some null - files on the fs )

I havn't experienced any errors since then ...

thx,
-Andreas

> Bye,
>     Oleg


