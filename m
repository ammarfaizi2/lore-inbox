Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279261AbRJWFyN>; Tue, 23 Oct 2001 01:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279263AbRJWFyD>; Tue, 23 Oct 2001 01:54:03 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:40421 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S279261AbRJWFxy>;
	Tue, 23 Oct 2001 01:53:54 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686b Bug - once again :(
In-Reply-To: <200110211326.PAA01192@mail.mwi-online.de>
	<3BD2DCFB.C00E93B6@home.com> <20011021224918.A30664@suse.cz>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 22 Oct 2001 15:55:18 +0200
In-Reply-To: Vojtech Pavlik's message of "Sun, 21 Oct 2001 22:49:18 +0200"
Message-ID: <m3n12jrd89.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> > I would certainly expect so.  I have a Gigabyte GA-7DX with the infamous
> > VIA
> > 686B southbridge...and an SBLive! Value...and I have no IDE devices at all
> > (complete SCSI).  I have never encountered data corruption.
> 
> Corruption *has* been reported on some scsi-only 686b systems, though. 

Right, there were few reports, including mine. As it turned out, disabling
MPS 1.4 and probably setting something related to SDRAM (don't remember
exactly) fixed the problems.
-- 
Krzysztof Halasa
Network Administrator
