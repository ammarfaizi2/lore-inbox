Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292654AbSBZSXc>; Tue, 26 Feb 2002 13:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292612AbSBZSWv>; Tue, 26 Feb 2002 13:22:51 -0500
Received: from viper.haque.net ([66.88.179.82]:15520 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S292657AbSBZSVA>;
	Tue, 26 Feb 2002 13:21:00 -0500
Date: Tue, 26 Feb 2002 13:20:59 -0500
Subject: Re: IDE error on 2.4.17
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
To: "Simon Turvey" <turveysp@ntlworld.com>
From: "Mohammad A. Haque" <mhaque@haque.net>
In-Reply-To: <000901c1beec$6ac68940$030ba8c0@mistral>
Message-Id: <9572D1E0-2AE5-11D6-9593-00306569F1C6@haque.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 26, 2002, at 12:38 , Simon Turvey wrote:

> After a large file (4gigs) transfer using Samba attempts to access the 
> file
> (also across Samba) resulted in lots of the following type of message.
>
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=250746,
> sector=250680
> end_request: I/O error, dev 03:01 (hda), sector 250680
>
> Can anyone point me in the direction of a reason/solution?

I got a similar error yesterday and this morning and asked about it on 
the ext3 list because I wasn't sure if it was fs related or hw.

http://marc.theaimsgroup.com/?l=ext3-users&m=101473048203232&w=2

--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                                mhaque@haque.net

   "Alcohol and calculus don't mix.             Developer/Project Lead
    Don't drink and derive." --Unknown          http://www.themes.org/
                                                batmanppc@themes.org
=====================================================================

