Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274539AbRIYRbJ>; Tue, 25 Sep 2001 13:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274554AbRIYRa7>; Tue, 25 Sep 2001 13:30:59 -0400
Received: from oe45.law3.hotmail.com ([209.185.240.213]:61448 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S274539AbRIYRak>;
	Tue, 25 Sep 2001 13:30:40 -0400
X-Originating-IP: [64.109.172.24]
From: "William Scott Lockwood III" <thatlinuxguy@hotmail.com>
To: "Nerijus Baliunas" <nerijus@users.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, "Alexander Viro" <viro@math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109251239250.24321-100000@weyl.math.psu.edu> <20010925170129.7AF958F659@mail.delfi.lt> <3BB0B9A7.2010906@antefacto.com> <OE51Xok84FTA7OIkUqL00001070@hotmail.com> <20010925172530.C6C5A8F77D@mail.delfi.lt>
Subject: Re: all files are executable in vfat
Date: Tue, 25 Sep 2001 12:31:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE458De4wk2UfxhUIBS00000fdf@hotmail.com>
X-OriginalArrivalTime: 25 Sep 2001 17:31:01.0454 (UTC) FILETIME=[D8773EE0:01C145E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry, I should have been more specific - should we have a dmask option?
So we could give the sysadmin/user the choice...

----- Original Message -----
From: "Nerijus Baliunas" <nerijus@users.sourceforge.net>
To: "William Scott Lockwood III" <thatlinuxguy@hotmail.com>;
<linux-kernel@vger.kernel.org>; "Alexander Viro" <viro@math.psu.edu>
Sent: Tuesday, September 25, 2001 12:25 PM
Subject: Re: all files are executable in vfat


> On Tue, 25 Sep 2001 12:19:09 -0500 William Scott Lockwood III
<thatlinuxguy@hotmail.com> wrote:
>
> WSLI> dmask?
> WSLI>
> WSLI> ----- Original Message -----
> WSLI> > I too used noexec to get around this problem. Is there anyway to
get umask
> WSLI> > to ignore directories? I.E. (v)fat should always leave directories
> WSLI> executable
> WSLI> > in my opinion?
>
> There is no such option in man and using it did not help.
>
>
> Regards,
> Nerijus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
