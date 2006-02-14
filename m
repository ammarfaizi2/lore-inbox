Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWBNN5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWBNN5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWBNN5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:57:54 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:31104 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030231AbWBNN5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:57:54 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 14:55:39 +0100
To: schilling@fokus.fraunhofer.de, dhazelton@enter.net
Cc: trudheim@gmail.com, nix@esperi.org.uk, linux-kernel@vger.kernel.org,
       davidsen@tmr.com, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F1E15B.nailMWZ92B3KZ@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <515e525f0602130446s1091f09ande10910f65a0f5f0@mail.gmail.com>
 <43F0A1F3.nailKUSV1V88J@burner>
 <200602131824.15810.dhazelton@enter.net>
In-Reply-To: <200602131824.15810.dhazelton@enter.net>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"D. Hazelton" <dhazelton@enter.net> wrote:

> > If you did know what a worm is, you would know that you are not correct:
> >
> > A WORM allows you to randomly write any sector once.
> >
> > A CD-R does not allows you to do this.
>
> Joerg, the practical definition of WORM is "Write Once, Read Many" - whether 
> or not it supports writes to random sectors is a moot point, a CDR does seem 
> to fit the bill of a "write once, read many" medium.

What you believe is irrelevent as long as it does not match the WORM device
definition.

See www.t10.org

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
