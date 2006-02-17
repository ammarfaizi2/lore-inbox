Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWBQMJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWBQMJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 07:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWBQMJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 07:09:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:17288 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751402AbWBQMJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 07:09:15 -0500
X-Authenticated: #428038
Date: Fri, 17 Feb 2006 13:09:10 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060217120910.GA11199@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr> <43F1F196.nailMWZE1HZK5@burner> <200602141710.37869.dhazelton@enter.net> <43F4652F.nail20W57J1QB@burner> <20060216115204.GA8713@merlin.emma.line.org> <43F4BF26.nail2KA210T4X@burner> <20060216181422.GA18837@merlin.emma.line.org> <43F5A5A4.nail2VC61NOF6@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F5A5A4.nail2VC61NOF6@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-17:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > Namespace split ATA/SCSI is unfixed in 2.01.01a06.
> 
> The namne space split is a Linux kernel bug

Define: name space := cdrecord/libscg device identifier,
specified as [transport:]bus,target,lun

It is a libscg bug, as proven before in
<http://www.ussg.iu.edu/hypermail/linux/kernel/0602.0/1103.html>

(Just so you don't get the last word.)

> > Linux uname() detection code is broken since 2.6.10 because it assumes
> > fixed-width fields.
> 
> Warnings related to Linux kernel bugs

OK. Since the bug is actually beneficial to Linux >= 2.6.10 users, I'm
not detailing. You don't need to fix it.

-- 
Matthias Andree
