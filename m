Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSGWXcg>; Tue, 23 Jul 2002 19:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318238AbSGWXcg>; Tue, 23 Jul 2002 19:32:36 -0400
Received: from vivi.uptime.at ([62.116.87.11]:47816 "EHLO mail.uptime.at")
	by vger.kernel.org with ESMTP id <S316883AbSGWXcf>;
	Tue, 23 Jul 2002 19:32:35 -0400
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Jan-Benedict Glaw'" <jbglaw@lug-owl.de>, <linux-kernel@vger.kernel.org>
Subject: RE: kbuild 2.5.26 - arch/alpha
Date: Wed, 24 Jul 2002 01:34:19 +0200
Organization: =?US-ASCII?Q?UPtime_Systemlosungen?=
Message-ID: <002801c232a1$7894db20$1211a8c0@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20020723132811.GX8891@lug-owl.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-MailScanner: Nothing found, baby
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Tue, 2002-07-23 14:42:03 +0200, Martin Brulisauer 
> <martin@uceb.org> wrote in message 
> <3D3D6B3B.25754.1392D3FD@localhost>:
> > On 21 Jul 2002, at 18:57, Oliver Pitzeier wrote:
> > > Oh... I did... :o( :o) But it's currently a mission 
> impossible. The 
> > > last kernel running fine for my alpha is 2.5.18 (with a lot of 
> > > patches...)
> 
> There was a quite good patch sent to l-k some weeks ago which
> (basically) still applies. I'm using this one (with watering 
> eyes waiting for a compileable Linus-Kernel...).

I go and search it...
 
> > Is there anybody who is willing to test such a patch
> > on different alpha's (I only have some XLT's, an AS800
> > and one AS250, so all alcor based systems with
> > ISA and PCI but without EISA and all are using 
> sys_alcor.c)? Further I 
> > can't test SMP with this _very_ old hardware.
> 
> I cannot test SMP either (I've not got a SMP alpha), but I 
> can test on Miata, Avanit and NoName.

I've got a AS1000. Noritake. But I do only have _one_ processor.
I don't believe that anybody buys me a second... :o(

Our Dual-Processor Machine (a DS20e) has been moved back to
Compaq a few month ago... On our seconds DS20e are running postgresql
databases which cannot be stopped. Not even for a few minutes while
rebooting...

-Oliver 


