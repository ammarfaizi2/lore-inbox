Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319126AbSHTAvS>; Mon, 19 Aug 2002 20:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319129AbSHTAvS>; Mon, 19 Aug 2002 20:51:18 -0400
Received: from [203.190.77.145] ([203.190.77.145]:51002 "HELO noc.chikka.com")
	by vger.kernel.org with SMTP id <S319126AbSHTAvR>;
	Mon, 19 Aug 2002 20:51:17 -0400
Message-ID: <021901c247e4$43ff5e00$0300000a@nocpc2>
From: "louie miranda" <louie@chikka.com>
To: "Ryan Cumming" <ryan@completely.kicks-ass.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <20020818021522.GA21643@waste.org> <20020819054359.GB26519@think.thunk.org> <02bc01c24746$9d08d600$0300000a@nocpc2> <200208190030.48180.ryan@completely.kicks-ass.org>
Subject: Re: *Challenge* Finding a solution (When kernel boots it does not display any system info)
Date: Tue, 20 Aug 2002 08:55:23 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll try this out.. thnx!!




=====
Thanks,
Louie Miranda...

WebUrl: http://axis0.endofinternet.org
Email: louie@linux.nu - louie@noc.chikka.com

----- Original Message -----
From: "Ryan Cumming" <ryan@completely.kicks-ass.org>
To: "louie miranda" <louie@chikka.com>; "linux-kernel"
<linux-kernel@vger.kernel.org>
Sent: Monday, August 19, 2002 3:30 PM
Subject: Re: *Challenge* Finding a solution (When kernel boots it does not
display any system info)


> On August (!)&18, 2002 23:06, louie miranda wrote:
> > Is there a patch or any configuration's, info*.
> > When the kernel boots.. it just display only the Lilo, etc. a few lines
> > after lilo.. and just pauses for a while and after a few seconds
> > display the login prompt?
> >
> > I've seen this once!, but i can't remember where...
> Passing "quiet" on the kernel command line, ie append="quiet" in
lilo.conf,
> turns off the kernel boot messages. You'll still have to find a way to get
> init and your initscripts to shut up, though.
>
> -Ryan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

