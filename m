Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRBMUuO>; Tue, 13 Feb 2001 15:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBMUuE>; Tue, 13 Feb 2001 15:50:04 -0500
Received: from server1.cosmoslink.net ([208.179.167.101]:44809 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S129112AbRBMUtt>; Tue, 13 Feb 2001 15:49:49 -0500
Message-ID: <012101c095ff$3b167320$bba6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Mike Galbraith" <mikeg@wen-online.de>
Cc: <linux-kernel@vger.kernel.org>,
        "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <Pine.Linu.4.10.10102132042480.755-100000@mikeg.weiden.de>
Subject: Re: Problem with Ramdisk in linux-2.4.1 
Date: Tue, 13 Feb 2001 12:55:00 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mike ,


----- Original Message -----
From: "Mike Galbraith" <mikeg@wen-online.de>
To: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 13, 2001 11:56 AM
Subject: Re: Problem with Ramdisk in linux-2.4.1


> On Tue, 13 Feb 2001, Jaswinder Singh wrote:
>
> > Dear Mike and others ,
> >
> > I am using compressed ramdisk , i can not turn off cramfs .
>
> (ok.. really is compressed)
>
> > my error messages are very strange and irreregular .
> >
> > i am getting 3 different kind of error messages :-
> >
> > invalid compressed format (err=1)
> > OR
> > invalid compressed format (err=2)
> > OR
> > crc error
> >
> > I am using gzip 1.2.4 (18 Aug 93)
> >
> > But when i use same ramdisk with old kernel like 2.2.12 , it works fine
.
>
> Can you point me to a cramfs generation procedure?  (never used
> cramfs.. know where the docs are, but could use a small time warp)
>

make ramdisk as you normally do and then compress it by gzip .

You can see documentation on Ramdisk in Documentation/ramdisk.txt if you
have some time ;)

Best Regards,

Jaswinder.
--
These are my opinions not 3Di.


> -Mike
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

