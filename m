Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbTAGXDj>; Tue, 7 Jan 2003 18:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTAGXDi>; Tue, 7 Jan 2003 18:03:38 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:18645 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267562AbTAGXDg>; Tue, 7 Jan 2003 18:03:36 -0500
Date: Wed, 08 Jan 2003 12:09:14 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Andre Hedrick <andre@pyxtechnologies.com>,
       Oliver Xymoron <oxymoron@waste.org>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <1540000.1041980954@localhost.localdomain>
In-Reply-To: <1041947930.20658.21.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>	
 <3E19B401.7A9E47D5@linux-m68k.org>	
 <17360000.1041899978@localhost.localdomain>	
 <1041942677.20658.0.camel@irongate.swansea.linux.org.uk>	
 <27130000.1041942696@localhost.localdomain>
 <1041947930.20658.21.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware acceleration is the right way to do any of this, agreed :-)

--On Tuesday, January 07, 2003 13:58:50 +0000 Alan Cox 
<alan@lxorguk.ukuu.org.uk> wrote:

> On Tue, 2003-01-07 at 12:31, Andrew McGregor wrote:
>> Or ESP, with or without encryption as well.
>>
>> But that does not acheive quite the same thing, because the iSCSI digest
>> is  another lightweight checksum, albeit stronger than most, and does
>> not  provide authentication.  So AH or ESP is stronger, but slower.
>
> AH permits multiple digests, they also happen to correspond to the
> hardware accelerated ones on things like the 3c990...
>
>


