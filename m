Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278364AbRKMTLC>; Tue, 13 Nov 2001 14:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278313AbRKMTKx>; Tue, 13 Nov 2001 14:10:53 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:16322 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278297AbRKMTKj>; Tue, 13 Nov 2001 14:10:39 -0500
Date: 13 Nov 2001 19:05:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8Cn1lUxXw-B@khms.westfalen.de>
In-Reply-To: <20011113171836.A14967@emma1.emma.line.org>
Subject: Re: 2.4.x has finally made it!
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20011113171836.A14967@emma1.emma.line.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthias.andree@stud.uni-dortmund.de (Matthias Andree)  wrote on 13.11.01 in <20011113171836.A14967@emma1.emma.line.org>:

> On Tue, 13 Nov 2001, Alastair Stevens wrote:
>
> > For those who haven't seen it yet, Moshe Bar at BYTE.com has revisited his
> > Linux 2.4 vs FreeBSD benchmarks, using 2.4.12 in this case:
> >
> >  http://www.byte.com/documents/s=1794/byt20011107s0001/1112_moshe.html
>
> Wow. That person is knowledgeable... NOT. Turning off fsync() for mail
> is just as good as piping it to /dev/null. See RFC-1123.

I rather think a non-fsync() system has a very much higher rate of  
successful mail deliveries than a /dev/null one, and only slightly (if at  
all) lower than a fsync() one.

Now, that slight difference *can* be rather important if you're a major  
mail hub - or it can be below the noise level in an end user system. In  
either case, however, *nobody* will accept /dev/null as an equivalent  
substitute.

Well, nobody but you.

MfG Kai
