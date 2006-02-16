Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWBPSO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWBPSO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWBPSO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:14:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:52141 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932548AbWBPSO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:14:27 -0500
X-Authenticated: #428038
Date: Thu, 16 Feb 2006 19:14:22 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060216181422.GA18837@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <43EB7BBA.nailIFG412CGY@burner> <Pine.LNX.4.61.0602140903400.7198@yvahk01.tjqt.qr> <43F1F196.nailMWZE1HZK5@burner> <200602141710.37869.dhazelton@enter.net> <43F4652F.nail20W57J1QB@burner> <20060216115204.GA8713@merlin.emma.line.org> <43F4BF26.nail2KA210T4X@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F4BF26.nail2KA210T4X@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-16:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > > I usually fix real bugs immediately after I know them.
> >
> > "Usually" is the key here. Sometimes, you refuse to fix real bugs
> > forever even if you're made aware of them, and rather shift the blame
> > on somebody else.
> 
> Show me a single real bug that I did not fix.

Namespace split ATA/SCSI is unfixed in 2.01.01a06.

Bogus warnings about Linux are unfixed in said version.

Bogus warnings about /dev/* are unfixed in said version.

Linux uname() detection code is broken since 2.6.10 because it assumes
fixed-width fields.

That makes four.

-- 
Matthias Andree
