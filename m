Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268105AbTBRXtP>; Tue, 18 Feb 2003 18:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268106AbTBRXtP>; Tue, 18 Feb 2003 18:49:15 -0500
Received: from ip252-142.choiceonecom.com ([216.47.252.142]:33292 "EHLO
	explorer.reliacomp.net") by vger.kernel.org with ESMTP
	id <S268105AbTBRXtO>; Tue, 18 Feb 2003 18:49:14 -0500
Message-ID: <3E52C86A.7060208@cendatsys.com>
Date: Tue, 18 Feb 2003 17:57:30 -0600
From: Edward King <edk@cendatsys.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Simon Kirby <sim@netnation.com>
CC: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-pre4] IDE hangs box after timeout
References: <Pine.LNX.4.44.0302181257260.16107-100000@radium.jvb.tudelft.nl> <20030218204627.GA28379@netnation.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby wrote:

>On Tue, Feb 18, 2003 at 01:25:40PM +0100, Robbert Kouprie wrote:
>  
>
>>Kernels older than 2.4.18 don't have LBA48 support, so would restrict the
>>20269 in its use. I also encountered the problem with kernel 2.4.17 +
>>Andre Hedrick's IDE patch, though. Also with 2.4.18/19 and various 2.4.20
>>-pre and -ac versions upto 2.4.20-rc1-ac4. Testing 2.4.21-pre4-ac4 now.
>>    
>>

Just wanted to jump in -- I have the same problem with 2.4.21-pre4-ac4. 
 I've got 2  PDC20268's running 4 WD 200GB drives.

Powersupply is a 550 watt  Antec.

I have a seperate 13gb drive that I'm booting from on the motherboard, 
so the system doesn't lock and reboots bring everything back fine.

I the bios on my PDC's is 2..20.0.14, tried with different cables (same 
problem).  The drives do seem to come back -- acts as if it has a hard 
time resetting the drives but finally comes back (after about 5-10 minutes).

Regards,

- Edward King




