Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269809AbRHINs7>; Thu, 9 Aug 2001 09:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269808AbRHINst>; Thu, 9 Aug 2001 09:48:49 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:18692 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S269807AbRHINsd>; Thu, 9 Aug 2001 09:48:33 -0400
Message-ID: <3B7294A8.D00AA900@loewe-komp.de>
Date: Thu, 09 Aug 2001 15:48:24 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Kompetenzzentrum Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.4-64GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: starke@commait.de, mirabilos@users.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: Status of AVM FritzCard PCI v2.0
In-Reply-To: <3B727A9E.D7686106@commait.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Starke wrote:
> 
> Hi all,
> 
> I'd like to know whether the new version of AVM FritzCard PCI
> is supported in recent (i.e. 2.4.7 and above) kernels.
> We have had a problem with Linux not recognising these devices,
> but no "old" versions can be purchased any longer.
> 

AFAIK there is no driver available. AVM Fritz 2.0 uses a different
ISDN chip (a proprietary one labeled with AVM), not the 
"good old Infineon PSB".

I tried both, AVM Fritz 1 and 2.0, version 2.0 is not supported in
2.4.5 - the older one works.

Consider buying an ELSA Microlink card, which BTW is also cheaper.
Try http://cdb.suse.de
