Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311945AbSCTSqt>; Wed, 20 Mar 2002 13:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311943AbSCTSqj>; Wed, 20 Mar 2002 13:46:39 -0500
Received: from mailrelay.nefonline.de ([212.114.153.196]:61444 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S311945AbSCTSq2>; Wed, 20 Mar 2002 13:46:28 -0500
Message-Id: <200203201846.TAA04737@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Bill Davidsen" <davidsen@tmr.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>
Date: Wed, 20 Mar 2002 19:46:43 +0100 (CET)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <Pine.LNX.3.96.1020320130543.7804A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [patch] My AMD IDE driver, v2.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002 13:11:03 -0500 (EST), Bill Davidsen wrote:

>On Wed, 20 Mar 2002, Daniela Engert wrote:
>
>> >This behavior is permitted by the specification, as far as I know -
>> 
>> Actually not. Have a look at page 36 of the current ATA6 specification.
>
>That's probably not the place to look, since drives will conform to the
>specs in place when they were designed. If older specs did not require
>automatic spinup, then ATA6 doesn't apply.

Well, then have a look at page 31 of the ATA3 spec. It tells you
basically the same - just a little more terse ;-)

Ciao,
  Dani


