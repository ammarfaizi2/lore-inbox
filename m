Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRCHFsk>; Thu, 8 Mar 2001 00:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131277AbRCHFs3>; Thu, 8 Mar 2001 00:48:29 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:46852 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S131276AbRCHFsR>;
	Thu, 8 Mar 2001 00:48:17 -0500
Date: Thu, 8 Mar 2001 02:47:47 -0300
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 (vt82c686 info)
Message-ID: <20010308024747.E788@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010306050546.C948@inxservices.com> <20010307201437.A5030@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010307201437.A5030@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 07 2001, Vojtech Pavlik wrote:
> Also, the vt82c686 will work just fine with Linux, but will be limited
> to UDMA33, because UDMA66 on this chip does reliably fail.

	How do I know which one I have? Using the revision of the
	chip?

	lspci only shows that I have a vt82c686 (revision 22 --
	perhaps this is the clue), but I have been using UDMA66 drives
	here with *no* corruption so far (or I haven't stressed my
	system enough to notice it).

	Here are the lines from my lspci which I think are relevant
	here:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                                                                      
	Any hints are more than welcome.

	[]s, Roger...

P.S.: This is an ASUS A7V mobo.
-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
