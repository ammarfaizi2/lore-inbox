Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUBYTuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUBYTuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:50:46 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:12795 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261456AbUBYTu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:50:27 -0500
Message-ID: <403CFC6D.9080602@matchmail.com>
Date: Wed, 25 Feb 2004 11:50:05 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Kyle Wong <kylewong@southa.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Any recommended PATA or SATA chip for kernel 2.6.x ?
References: <004c01c3fb66$b7ba9440$9c02a8c0@southa.com> <20040225174404.GA662@merlin.emma.line.org>
In-Reply-To: <20040225174404.GA662@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Wed, 25 Feb 2004, Kyle Wong wrote:
> 
> 
>>I found in the market that most PCI IDE card are using "siimage (CMD?),
>>HiPoint and IT8212 chip, are they working well with 2.6.x ?
> 

Hi!

> 
> http://kerneltrap.org/node/view/1787

Any newer info from Jeff?

A lot can happen in three months... :-D

> 
> http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/dev/ata/ata-chipset.c?only_with_tag=MAIN#rev1.50
> 
> http://docs.freebsd.org/cgi/mid.cgi?402F88AB.8010003
> http://docs.freebsd.org/cgi/mid.cgi?200311262104.hAQL4ICN024652
> http://docs.freebsd.org/cgi/mid.cgi?40250AF7.3010804
> http://docs.freebsd.org/cgi/mid.cgi?4022B5EF.4030807
> http://docs.freebsd.org/cgi/mid.cgi?4023BF1C.6020008

OK, I'll be sure to avoid the SiI3112A based boards.

Mike
