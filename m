Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270514AbRHIRsH>; Thu, 9 Aug 2001 13:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270491AbRHIRr5>; Thu, 9 Aug 2001 13:47:57 -0400
Received: from zok.sgi.com ([204.94.215.101]:35308 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S270484AbRHIRrt>;
	Thu, 9 Aug 2001 13:47:49 -0400
Subject: Re: [eepro100] Re: Problem with Linux 2.4.7 and builtin eepro on
	Intel's EEA2 motherboard.
From: Florin Andrei <florin@sgi.com>
To: Luc Lalonde <llalonde@giref.ulaval.ca>
Cc: Ben Greear <greearb@candelatech.com>, LKML <linux-kernel@vger.kernel.org>,
        "eepro100@scyld.com" <eepro100@scyld.com>
In-Reply-To: <Pine.LNX.4.33.0108082157470.18777-100000@merlin.giref.ulaval.ca>
In-Reply-To: <Pine.LNX.4.33.0108082157470.18777-100000@merlin.giref.ulaval.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 09 Aug 2001 10:46:17 -0700
Message-Id: <997379177.31234.5.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Aug 2001 21:58:39 -0400, Luc Lalonde wrote:
> Hello Fiorin,
> 
> What is your uptime on this machine.  I've come to the same conclusion and
> I'm up to 13 days with the Intel e100 driver.

With kernel's driver, the interface was frozen in 30 minutes. I had to
ifdown / ifup the interface.
With Intel's driver, it works for days with no problem. But i never had
an uptime bigger than one week on that system.

-- 
Florin Andrei

