Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136869AbRA2CRX>; Sun, 28 Jan 2001 21:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144924AbRA2CRO>; Sun, 28 Jan 2001 21:17:14 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.159.219.14]:43967 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S136869AbRA2CRB>; Sun, 28 Jan 2001 21:17:01 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux-2.4.1-pre11
Date: Mon, 29 Jan 2001 03:20:36 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="ISO-8859-1"
Cc: Andrew Grover <andrew.grover@intel.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Linux ACPI List" <acpi@phobos.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.LNX.4.10.10101281346030.4151-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10101281346030.4151-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01012903203600.00304@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 28. Januar 2001 22:46 schrieb Linus Torvalds:
> On Sun, 28 Jan 2001, Dieter Nützel wrote:
> > > I just uploaded it to kernel.org, and I expect that I'll do the final
> > > 2.4.1 tomorrow, before leaving for NY and LinuxWorld. Please test that
> > > the pre-kernel works for you..
> >
> > Hello Linus,
> >
> > can we please see Andrew's latest ACPI fixes ([Acpi] ACPI source release
> > updated: 1-25-2001)  in 2.4.1 final?
>
> Does it fix stuff? Andrew?

I am the loser :-(
2.4.1-pre10 (with Andrew's ACPI fixes included) and
2.4.1-pre11 + 1-25-2001 patch bring back the pppd slowdown on my system.

2.4.1-pre9 was fine...

AMD K7
MSI MS-6167 Rev. 1.0B (Irongate C4)

-Dieter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
