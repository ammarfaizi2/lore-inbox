Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSFOL23>; Sat, 15 Jun 2002 07:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSFOL22>; Sat, 15 Jun 2002 07:28:28 -0400
Received: from lech.pse.pl ([194.92.3.7]:11691 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S315279AbSFOL21>;
	Sat, 15 Jun 2002 07:28:27 -0400
Date: Sat, 15 Jun 2002 13:27:51 +0200
From: Lech Szychowski <lech.szychowski@pse.pl>
To: Nick Papadonis <nick@coelacanth.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Arkeia Back + v2.4.18
Message-ID: <20020615112751.GA27194@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: Nick Papadonis <nick@coelacanth.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <m38z5jvz2f.fsf@noop.bombay> <20020614144554.GA7428@lech.pse.pl> <m3hek5fw1b.fsf@noop.bombay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Polskie Sieci Elektroenergetyczne S.A.
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you using the 'free' version?  

No, the commercial/licensed 4.2.10-1.

> What type of SCSI controller and SCSI tape drive do you have?

Good old 53c810 rev 01 and Exabyte Mammoth EXB-8900.
The tape shares SCSI bus with one SCSI disk (this
machine is equipped with just one disk, an old Seagate
Barracuda ST32550N). I believe we're sometimes pushing
this hardware up to its limits when backing up fast
machines over a switched 100Mbps. No errors though.

> My problem could be in the AIC7XXXX driver using my 29160 card.

Can't tell, I have never used Arkeia in real world setups
with an Adaptec card. For tests, yes, but not in a prodution
environments.

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
