Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSF1X5D>; Fri, 28 Jun 2002 19:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSF1X5C>; Fri, 28 Jun 2002 19:57:02 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62725 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317184AbSF1X5C>; Fri, 28 Jun 2002 19:57:02 -0400
Date: Sat, 29 Jun 2002 01:59:19 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Status of write barrier support for 2.4?
Message-ID: <20020628235919.GA9036@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20020627104534.GA31084@merlin.emma.line.org> <20020628200203.A777@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020628200203.A777@suse.de>
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2002, Jens Axboe wrote:

> On Thu, Jun 27 2002, Matthias Andree wrote:
> > Hi,
> > 
> > what is the status of write barrier support in Linux?
> 
> We have stable support for IDE (ie block layer barrier support works,
> IDE implementation works). I doubt we'll ever do 2.4 SCSI support,
> it would be too invasive to really make it safe.

Alas, my system runs on some nice U160-SCSI drive. Looks like I should
follow 2.5 in the not too distant future then ;-)

OK, thanks.
