Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310130AbSCPHmy>; Sat, 16 Mar 2002 02:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310137AbSCPHmp>; Sat, 16 Mar 2002 02:42:45 -0500
Received: from [203.162.56.202] ([203.162.56.202]:15350 "HELO
	mail.vnsecurity.net") by vger.kernel.org with SMTP
	id <S310130AbSCPHmg>; Sat, 16 Mar 2002 02:42:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: MrChuoi <MrChuoi@yahoo.com>
Reply-To: MrChuoi@yahoo.com
To: J Sloan <joe@tmsusa.com>
Subject: Re: Linux 2.4.19-pre3-ac1
Date: Sat, 16 Mar 2002 14:52:16 +0700
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16lgjZ-0002Uh-00@the-village.bc.nu> <20020316052309.9B9F44E51A@mail.vnsecurity.net> <3C92DF96.6010904@tmsusa.com>
In-Reply-To: <3C92DF96.6010904@tmsusa.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020316074223.A88AF4E534@mail.vnsecurity.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 March 2002 01:00 pm, J Sloan wrote:
> >Tested with:
> >2.4.19-pre3: OK
> >2.4.19-pre2-ac4: cannot allocate memory
> >2.4.19-pre3-ac1: cannot allocate memory
> >2.4.19-pre2aa*: OK
> >2.4.19-pre3aa*: OK
>
> I'd bet they are all on the borderline -
> It may be that you are simply exhausting vm.
All above kernels was build with the same .config. So, can you explain why
JBuilder4 can work normally with 2.4.19-pre3 vanilla but 2.4.19-pre-ac.

> What if you make a decent swap partition,
> say 512 MB or so, and try the tests again?
Ofcourse if I have more enough space ;)

MrChuoi
