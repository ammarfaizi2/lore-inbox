Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278911AbRKMUnP>; Tue, 13 Nov 2001 15:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278890AbRKMUnG>; Tue, 13 Nov 2001 15:43:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54536 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278829AbRKMUmy>; Tue, 13 Nov 2001 15:42:54 -0500
Message-ID: <3BF185A9.8000200@zytor.com>
Date: Tue, 13 Nov 2001 12:42:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: fdutils.
In-Reply-To: <Pine.GSO.3.96.1011113210638.11222D-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

> On Tue, 13 Nov 2001, H. Peter Anvin wrote:
> 
> 
>>I believe both, but the important thing is that it's an ATAPI/SCSI
>>implementation, including a soft eject button, and not that horrible
>>legacy floppy crap.
>>
> 
>  Hmm, Sun used to have a software-controlled standard floppy drives years
> ago... 
> 


I'm not talking about Suns.


> 
>>That wasn't what kept it from becoming standard, though.  The marketing of
>>Zip was a bit too good, but Zip couldn't have displaced the legacy floppy,
>>since it wasn't compatible.
>>
> 
>  Based on local obervations hardly anyone uses floppies anymore...  They
> are mostly used for system rescue purposes, where the kind of a device
> doesn't really matter.
> 


... except that you no longer can fit a reasonable system rescue/install
setup on a floppy, so it *defintitely* matters.  Also, the floppy device
is like a rash all over the hardware; it maintains a highly undesirable
legacy.

	-hpa




