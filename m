Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbTCTL5a>; Thu, 20 Mar 2003 06:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbTCTL5a>; Thu, 20 Mar 2003 06:57:30 -0500
Received: from sarge.hbedv.com ([217.11.63.11]:157 "EHLO sarge.hbedv.com")
	by vger.kernel.org with ESMTP id <S261413AbTCTL53>;
	Thu, 20 Mar 2003 06:57:29 -0500
Date: Thu, 20 Mar 2003 13:08:29 +0100
From: Wolfram Schlich <wolfram@schlich.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared IRQs
Message-ID: <20030320120829.ALLYOURBASEAREBELONGTOUS.F4264@bla.fasel.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030319221608.ALLYOURBASEAREBELONGTOUS.A29767@bla.fasel.org> <1048124539.647.18.camel@irongate.swansea.linux.org.uk> <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org> <20030320095158.221cf888.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320095158.221cf888.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Organization: Axis of Weasel(s)
X-Complaints-To: bla@fasel.org
X-IRC: wschlich at irc.freenode.net
X-Messenger: ICQ: 35713642, MSN: bla@fasel.org, YIM: wolfram_schlich, AIM: wolframschlich
X-Registered-Linux-User: 187858 (http://counter.li.org)
X-Warning: E-Mail may contain unsmilyfied humor and/or satire.
X-What-Happen: Somebody set up us the bomb.
X-Accept-Language: de, en, fr
X-GPG-Key: 0xCD4DF205 (http://wolfram.schlich.org/wschlich.asc, x-hkp://wwwkeys.de.pgp.net)
X-GPG-Fingerprint: 39EC 98CA 4130 E59A 1041  AD06 D3A1 C51D CD4D F205
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled Mar 24 2002 15:02:51)
X-Face: |P()Q^fx-{=,K-3g?5@Id4o|o{Xf_5v:z3WIhR3fOW-$,*=[#[Qq<,@P!OsXbR|i6n=]B<3mzGC++F@K#wvoLEnIZuTR6wPCMQfxq!';9w[TiP3Bhz"r&$7eGFq7us@Z5Qd$3W[3W3:U7biTNZgf"<]LqwS
X-Operating-System: Linux prometheus 2.4.21-pre5-grsec-1.9.9c #3 SMP Thu Mar 20 00:10:58 CET 2003 i686 unknown
X-Uptime: 1:06pm up 4:29, 2 users, load average: 0.02, 0.03, 0.00
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.9; AVE: 6.18.0.3; VDF: 6.18.0.18; host: mx.bla.fasel.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephan von Krawczynski <skraw@ithnet.com> [2003-03-20 09:53]:
> On Thu, 20 Mar 2003 08:22:59 +0100
> Wolfram Schlich <wolfram@schlich.org> wrote:
> 
> > [died ide with shared interrupts]
> 
> Don't know if it is related, but I experienced the same thing sharing PDC with
> 3com GBit (Broadcom) and it was indeed solved by latest version of tg3-driver
> from Jeff. Maybe there are analogies between the two cases concerning the nic
> drivers, too.

Interesting. Well, I have the problems with both the 3c59x (100Mb) and
the ns83820 (1000Mb) drivers...
-- 
Mit freundlichen Gruessen / Yours sincerely
Wolfram Schlich; Friedhofstr. 8, D-88069 Tettnang; +49-(0)178-SCHLICH
