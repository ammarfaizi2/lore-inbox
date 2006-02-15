Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWBOGNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWBOGNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWBOGNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:13:35 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:28744 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751035AbWBOGNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:13:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:organization:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=gCEinO9db4fyEZd2/78YpD9wgkI9X13r2o33KbgaI43e15S4+ERROzwzhnTbg+2XIBd4/Kg04bIx4oH+Dwc4tCXBhzpgTOCjb7Ca1bkAIJ2zFrBj/KXzOIfj+fp1TFohNfRZgpsQiGsrPrlFeuPnaSc+hdrU760CDX4ARBUD0Ec=
Date: Wed, 15 Feb 2006 06:13:31 -0000
To: "Rob Landley" <rob@landley.net>,
       "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: "Anders Karlsson" <trudheim@gmail.com>
Organization: Trudheim Technology Limited
Cc: "Linux-Kernel mailing list" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602141751.02153.rob@landley.net> <20060215000420.GB21088@merlin.emma.line.org> <200602142155.03407.rob@landley.net>
Content-Transfer-Encoding: 8bit
Message-ID: <op.s4z3ktyviv906l@lenin>
In-Reply-To: <200602142155.03407.rob@landley.net>
User-Agent: Opera Mail/9.00 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006 02:55:03 -0000, Rob Landley <rob@landley.net> wrote:

[snip]
> The last gasp of the SCSI bigots is Serial Attached Scsi.  It's  
> hilarious. Electrically it's identical (they just gold-plate the
> connectors and such so they can charge more for it).  The
> giveaway is that you can plug a SATA drive into a SAS controller
> and it works on "dual standard" controller firmware.
> Which one's going to have the unit volume to be cheap and sell
> through its inventory to bring out new generations faster?  And
> which one is exactly the same technology with buckets of hype,
> slightly different firmware, and a huge markup for the people who
> still think that because ISA sucked, its designated successor PCI
> can't be trusted?
>
> Buying the exact same technology for way more money, based on a  
> two-decade old bias in an industry where a given generation of
> hardware becomes obsolete every 3 years.  Funny to me, anyway...
[snip]

SAS will have the old SCSI advantage of multiple devices per
chain though. That is something that is very off-putting about
SATA actually that you need as many interfaces as you have
disks.

For commercial reasons, you'll probably find that the more
expensive SAS disks will be the ones with the lower seek-times,
the better warranties etc. We may not like it, but it ain't
going to change in a hurry.

Regards,

-- 
Anders Karlsson <anders@trudheim.com>
QA Engineer | GnuPG Key ID - 0x4B20601A
