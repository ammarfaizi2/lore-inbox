Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293445AbSCSBaL>; Mon, 18 Mar 2002 20:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293447AbSCSBaC>; Mon, 18 Mar 2002 20:30:02 -0500
Received: from [203.162.56.202] ([203.162.56.202]:60405 "HELO
	mail.vnsecurity.net") by vger.kernel.org with SMTP
	id <S293445AbSCSB3u>; Mon, 18 Mar 2002 20:29:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: MrChuoi <MrChuoi@yahoo.com>
Reply-To: MrChuoi@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3-ac1
Date: Tue, 19 Mar 2002 08:39:41 +0700
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16mvYx-0004re-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020319012940.430CC4E534@mail.vnsecurity.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 March 2002 06:44 pm, Alan Cox wrote:
> > - 2.4.19-pre-ac: kswapd try to swap out and access disk continuously.
> > Whole system is slow down and un-interactivable.
>
> echo "2" >/proc/sys/vm/overcommit_memory
Couldn't load JBuilder (Out of memomy).

echo "1" >/proc/sys/vm/overcommit_memory => solved my 1st problem. I can
build and run my project from inside JBuilder. But OOM killer still doesn't
work (2nd). Anyway, thank you. I will play with your Magic numbers later,
Wizard ;). There are still alot of things to play with.
