Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282267AbRKWW0T>; Fri, 23 Nov 2001 17:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282266AbRKWW0K>; Fri, 23 Nov 2001 17:26:10 -0500
Received: from 24-240-35-67.hsacorp.net ([24.240.35.67]:1152 "HELO
	majere.epithna.com") by vger.kernel.org with SMTP
	id <S282260AbRKWW0E> convert rfc822-to-8bit; Fri, 23 Nov 2001 17:26:04 -0500
Date: Fri, 23 Nov 2001 15:21:12 -0500 (EST)
From: <listmail@majere.epithna.com>
To: Martin Eriksson <nitrax@giron.wox.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE is still crap.. or something
In-Reply-To: <014a01c17456$504197d0$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.33.0111231520390.224-100000@majere.epithna.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as an FYI...I am not seeing this on my ht366...runs nice and
speedy...

On Fri, 23 Nov 2001, Martin Eriksson wrote:

> ----- Original Message -----
> From: "Martin Eriksson" <nitrax@giron.wox.org>
> To: <linux-kernel@vger.kernel.org>
> Sent: Friday, November 23, 2001 8:11 PM
> Subject: IDE is still crap.. or something
>
>
> > Well, just wanted to tell you that 2.4.15 still slows down to a crawl when
> > copying a 500MB file between two hard drives (running ext3). I have tried
> > any of the -c -u -m -W settings in hdparm. I even applied the 2.4.14 IDE
> > patch (after fixing the rejects) but no go.
> >
> > Even iptables is affected, because it takes forever to surf the internet
> > from my behind-linux-firewall windows computer.
> >
> > I'm right now trying to apply the preemptive-kernel patch to 2.4.15 but it
> > had some strange rejects so it will be exciting to see if it works. I get
> > good response from the -ac kernel series though.
>
> I applied the ide patch and the preemptive-kernel patch, and so far so good.
> Response is up again, but I'm not sure how well I fixed the .rej files.
> There were some reference to a "still_running" label that I simply
> ignored... *shrug*
>
> Btw, i run my (pretty slow) hard disks on my BP6 HPT366 controller.
>
> _____________________________________________________
> |  Martin Eriksson <nitrax@giron.wox.org>
> |  MSc CSE student, department of Computing Science
> |  Umeå University, Sweden
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

