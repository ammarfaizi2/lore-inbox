Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310491AbSCPRko>; Sat, 16 Mar 2002 12:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310488AbSCPRke>; Sat, 16 Mar 2002 12:40:34 -0500
Received: from [203.162.56.202] ([203.162.56.202]:41428 "HELO
	mail.vnsecurity.net") by vger.kernel.org with SMTP
	id <S310491AbSCPRkZ>; Sat, 16 Mar 2002 12:40:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: MrChuoi <MrChuoi@yahoo.com>
Reply-To: MrChuoi@yahoo.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, joe@tmsusa.com (J Sloan)
Subject: Re: Linux 2.4.19-pre3-ac1
Date: Sun, 17 Mar 2002 00:50:09 +0700
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16mI0I-0006kp-00@the-village.bc.nu>
In-Reply-To: <E16mI0I-0006kp-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020316174015.CB2314E534@mail.vnsecurity.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 March 2002 12:30 am, Alan Cox wrote:
> > >2.4.19-pre2-ac4: cannot allocate memory
> > >2.4.19-pre3-ac1: cannot allocate memory
> > >2.4.19-pre2aa*: OK
> >
> > I'd bet they are all on the borderline -
> > It may be that you are simply exhausting vm.
>
> It may well be borderline but its certainly interesting the rmap vm thinks
> it is out of memory first. Whats the overcommitted_AS value just before it
> reports that it cannot allocate memory.
>
> I'm also interested to know if it occurs with a lot more swap. It might be
> a false report coming from a bug in the vm accounting changes too
I'm not using my home desktop right now. IIRC after loading JBuilder:

Free Mem: ~3MB
Free Swap: ~64MB
Cache: ~32Mb

HTH,

MrChuoi
