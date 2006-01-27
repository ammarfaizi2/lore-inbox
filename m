Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWA0X2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWA0X2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbWA0X2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:28:09 -0500
Received: from mail.gmx.net ([213.165.64.21]:28626 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422683AbWA0X2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:28:07 -0500
X-Authenticated: #428038
Date: Sat, 28 Jan 2006 00:28:03 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060127232803.GA4622@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner> <43D7B5BE.60304@gmx.de> <43D89B7C.nailDTH38QZBU@burner> <5a2cf1f60601260234r4c5cde3fu3e8d79e816b9f3fd@mail.gmail.com> <43D8D69F.nailE2XAJ2XIA@burner> <200601270524.k0R5OIS8019541@turing-police.cc.vt.edu> <43DA1CD6.nailFHI6QV3LO@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA1CD6.nailFHI6QV3LO@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006, Joerg Schilling wrote:

> Valdis.Kletnieks@vt.edu wrote:
> 
> > And you know what? I really don't give a flying <fornicate> in a rolling donut
> > what FreeBSD calls the device. If I did, I'd have installed FreeBSD.  But I
> 
> It has been mentioned here many times, you only need to read it.
> 
> FreeBSD comes with a T-10 (SCSI) compliant CAM interface that uses a multiplex 
> device and dev=b,t,l to address the devices. This is true for _all_ kind of 
> SCSI devices and thus includes ATAPI transport.

Is CAM relevant at all for ATAPI, USB, IEEE1394, parport and other
transports? Where is the link between ATAPI's SCSI/MMC command set and
SCSI CAM standard applying to ATAPI devices? (File name of the standard
or latest draft and chapter is sufficient.)

-- 
Matthias Andree
