Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTLDPBb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 10:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTLDPBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 10:01:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50890 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262327AbTLDPBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 10:01:25 -0500
Message-ID: <3FCF4C32.5040101@pobox.com>
Date: Thu, 04 Dec 2003 10:01:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnaud Launay <asl@launay.org>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <20031204081732.GC5376@launay.org>
In-Reply-To: <20031204081732.GC5376@launay.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaud Launay wrote:
> Le Wed, Dec 03, 2003 at 03:44:46PM -0500, Jeff Garzik a écrit:
> 
>>Intel ICH5
>>----------
>>Summary:  No TCQ.  Looks like a PATA controller, but with a few
>>added, non-standard SATA port controls.
> 
> 
> No plan to add the so-called "raid" capabilities of the 82801EB ?

AFAIK the raid capabilities are entirely in software.

And Intel just wrote and posted this component.  Look for "iswraid" in 
the linux-kernel archives.


>>Silicon Image 3112
> 
> 
> Same here, is support for the 3114 underway ? Saw a message from

Underway, but beyond that cannot comment :)

	Jeff



