Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262845AbTCKGig>; Tue, 11 Mar 2003 01:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262846AbTCKGig>; Tue, 11 Mar 2003 01:38:36 -0500
Received: from tag.witbe.net ([81.88.96.48]:36618 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S262845AbTCKGif>;
	Tue, 11 Mar 2003 01:38:35 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Matthew Harrell'" 
	<mharrell-dated-1047753657.4eb01d@bittwiddlers.com>,
       "'Kernel List'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64 boot problems
Date: Tue, 11 Mar 2003 07:49:14 +0100
Message-ID: <00c001c2e79a$5567c8c0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20030310184052.GA1623@bittwiddlers.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you try the same config without APIC and IO APIC for Uniprocessor
?
I've a problem that is directly related to 2.5.64 and these features...

Without them, 2.5.64 just boots fine...

Regards,
Paul

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Matthew Harrell
> Sent: Monday, March 10, 2003 7:41 PM
> To: Kernel List
> Subject: Re: 2.5.64 boot problems
> 
> 
> > this is the first time i tried to use a 2.5.x kernel. i compiled it 
> > successfully but at boot time it stops at "ok booting kernel"
> 
> I've got the same problem on my HP ZT1195 laptop and it only 
> just started 
> with the 2.5.64 kernels (and all bk snapshots).  2.5.63 
> worked fine.  Config attached below
> 
> -- 
>   Matthew Harrell                          I no longer need 
> to punish, deceive,
>   Bit Twiddlers, Inc.                       or compromise 
> myself, unless I want
>   mharrell@bittwiddlers.com                 to stay employed.
> 

