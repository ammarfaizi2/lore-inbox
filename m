Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282780AbRK0EBg>; Mon, 26 Nov 2001 23:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282782AbRK0EBZ>; Mon, 26 Nov 2001 23:01:25 -0500
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:62143 "EHLO
	harrier.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S282779AbRK0EBP>; Mon, 26 Nov 2001 23:01:15 -0500
Message-ID: <01c701c176f8$058fed50$0a00a8c0@intranet.mp3s.com>
Reply-To: "Sean Elble" <S_Elble@yahoo.com>
From: "Sean Elble" <S_Elble@yahoo.com>
To: "Doug Ledford" <dledford@redhat.com>
Cc: "Nathan G. Grennan" <ngrennan@okcforum.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org> <01b501c176f6$8bac6cd0$0a00a8c0@intranet.mp3s.com> <3C030EFB.8060001@redhat.com>
Subject: Re: Unresponiveness of 2.4.16
Date: Mon, 26 Nov 2001 23:00:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not exactly.  That kernel is -ac based (plus lots of other patches, some
> of them VM tweaks) and is a Van Riel VM.

Right; it's not the "stock" 2.4.9 VM, but it isn't Andrea's either . . . one
of those gray area things. :-) I guess we just have to wait until he posts
the results with the "stock" 2.4.9 kernel to see if Red Hat fixed the
problem or not. Have a good one!

-----------------------------------------------
Sean P. Elble
Editor, Writer, Co-Webmaster
ReactiveLinux.com (Formerly MaximumLinux.org)
http://www.reactivelinux.com/
elbles@reactivelinux.com
-----------------------------------------------

----- Original Message -----
From: "Doug Ledford" <dledford@redhat.com>
To: "Sean Elble" <S_Elble@yahoo.com>
Cc: "Nathan G. Grennan" <ngrennan@okcforum.org>;
<linux-kernel@vger.kernel.org>
Sent: Monday, November 26, 2001 10:56 PM
Subject: Re: Unresponiveness of 2.4.16


> Sean Elble wrote:
>
> >>I tried switching to Redhat's 2.4.9-13 kernel and it acts Alot better.
> >>Not only does 2.4.9-13 not get the 30 second delay, but it also seems to
> >>take advantage of caching. 2.4.16 takes the same moment of time each
> >>time, even tho it should have cached it all into memory the first time.
> >>
> >
> > Unless Red Hat has specifically added Andrea's new VM code to the 2.4.9
> > kernel, then that kernel is still using the old VM.
>
>
> Not exactly.  That kernel is -ac based (plus lots of other patches, some
> of them VM tweaks) and is a Van Riel VM.
>
>
>
>
> --
>
>   Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>        Please check my web site for aic7xxx updates/answers before
>                        e-mailing me about problems

