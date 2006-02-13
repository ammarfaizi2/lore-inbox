Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWBMXPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWBMXPT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWBMXPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:15:19 -0500
Received: from smtp.enter.net ([216.193.128.24]:58374 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030264AbWBMXPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:15:17 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 18:24:15 -0500
User-Agent: KMail/1.8.1
Cc: trudheim@gmail.com, nix@esperi.org.uk, linux-kernel@vger.kernel.org,
       davidsen@tmr.com, axboe@suse.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <515e525f0602130446s1091f09ande10910f65a0f5f0@mail.gmail.com> <43F0A1F3.nailKUSV1V88J@burner>
In-Reply-To: <43F0A1F3.nailKUSV1V88J@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131824.15810.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 10:12, Joerg Schilling wrote:
> Anders Karlsson <trudheim@gmail.com> wrote:
> > On 2/13/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> > [snip]
> >
> > > -       Older CD-writers identified as WORM although a CD-R is not a
> > > WORM.
> >
> > Nitpicking I know, but technically, CD-R is WORM in the case of single
> > session write. And as long as the writer works, who cares if it is
> > labled WORM, CD-R or Earthworm..
>
> If you did know what a worm is, you would know that you are not correct:
>
> A WORM allows you to randomly write any sector once.
>
> A CD-R does not allows you to do this.

Joerg, the practical definition of WORM is "Write Once, Read Many" - whether 
or not it supports writes to random sectors is a moot point, a CDR does seem 
to fit the bill of a "write once, read many" medium.

DRH
