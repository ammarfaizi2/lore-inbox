Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLOKqF>; Fri, 15 Dec 2000 05:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOKpz>; Fri, 15 Dec 2000 05:45:55 -0500
Received: from c334580-a.snvl1.sfba.home.com ([65.5.27.33]:29456 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129324AbQLOKpo>; Fri, 15 Dec 2000 05:45:44 -0500
Date: Fri, 15 Dec 2000 02:15:39 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 + reiserfs + smp
In-Reply-To: <Pine.LNX.4.10.10012150131280.31093-100000@home.suse.com>
Message-ID: <Pine.LNX.4.30.0012150215080.6049-100000@playtoy.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks Chris. Appreciate the fast getback.


On Fri, 15 Dec 2000, Chris Mason wrote:

>
>
> On Fri, 15 Dec 2000, David D.W. Downey wrote:
> >
> > I've been reading the thread regarding data corruption with 2.4.0-test12,
> > reiserfs, and smp.
> >
> > Unfrotunately I've not seen any resolution announced about this. Is this
> > still an issue or has this been fixed?
> >
> reiserfs and test12 won't play nice at all right now due to the
> ll_rw_block changes.  I'm testing a patch now, it should be done sometime
> today.
>
> -chris
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-- 

David D.W. Downey
RHCE


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
