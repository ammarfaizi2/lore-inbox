Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTJSUJh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTJSUJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 16:09:37 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:30338 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S262161AbTJSUJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 16:09:35 -0400
Message-ID: <017301c3967d$48bc1530$0514a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Cc: <linux-kernel@vger.kernel.org>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>       <1066579176.7363.3.camel@milo.comcast.net><41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>       <yw1x3cdpgm46.fsf@users.sourceforge.net>    <48232.192.168.9.10.1066590873.squirrel@ncircle.nullnet.fi>    <013801c39677$035e1d40$0514a8c0@HUSH> <49794.192.168.9.10.1066592366.squirrel@ncircle.nullnet.fi>
Subject: Re: HighPoint 374
Date: Sun, 19 Oct 2003 22:12:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomi,

Copied one large DVD image from one to drive to another a couple of times,
no problems whatsoever. Compared the file each time, everything looks good.

As for the email, it's not my ISP gateway but mine personally. By blocking
the entire Telefonica IP pool you are denying access to a huge userbase, as
Telefonica is, in the end, the ISP for almost everyone here. But well, it's
your decision :-)

----- Original Message ----- 
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, October 19, 2003 21:39
Subject: Re: HighPoint 374


>
> > Tomy,
> >
> > The
> >
> > hdparm -m0 device
> >
> > seems to have fixed the problem for me. I'll try increasing the number
in
> > the following days and run extensive tests, but for now, it's quite
> > enough.
>
> That is *very* interesting. I quess that's about the only hdparm
> option that I have never tried before. I'm really interested in hearing
> if that really fixes the problem for you and for good. The thing is
> that the machine with HPT374-chip is running as a server so I'm
> not very eager to use it as a test bed (unless it's absolutely necessary).
> Please, if it's possible for you, try to copy say two big files from
> one disk to another at the same time couple of times in order to see if
> your machine is able to handle it ... I have been able to run mine
> 2-3 days in the past without any problems if there are _no_ major
> disk transfers going on.
>
> The question of course is why does that hdparm option seem to fix
> the problem in this case ? Is it perhaps a bug in HPT374-driver or
> some lower IDE-layer ? (Just quessing ...)
>
> > BTW your email server doesn't seem to like my address and refuses to
> > deliver
> > any mail, if you aren't running it maybe you should tell the admin that
> > he's
> > blocking Spain's largest ISP for some reason?
>
> I'm sorry, I don't accept mails coming from dsl/cable/modem-pools due to
> high amount of spam. I will accept mails coming from your ISP's mail
> gateway though.
>
> Regards,
> Tomi Orava
>
>
> -- 
> Tomi.Orava@ncircle.nullnet.fi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

