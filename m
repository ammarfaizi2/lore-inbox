Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273908AbRIXNgM>; Mon, 24 Sep 2001 09:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273909AbRIXNgC>; Mon, 24 Sep 2001 09:36:02 -0400
Received: from f138.law11.hotmail.com ([64.4.17.138]:21266 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S273908AbRIXNfv>;
	Mon, 24 Sep 2001 09:35:51 -0400
X-Originating-IP: [194.6.79.172]
From: "Rob MacGregor" <rob_macgregor@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.10 and ACPI
Date: Mon, 24 Sep 2001 13:36:11 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F138NIPukg3nOpj53Xa000046c3@hotmail.com>
X-OriginalArrivalTime: 24 Sep 2001 13:36:11.0954 (UTC) FILETIME=[E00E6920:01C144FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should mention that I get exactly the same result from 2.4.9.  I hadn't 
tried ACPI before then.

On both my desktop (based on a SuperMicro P6DGU with the Intel 440GX 
chipset, l) and my laptop (HP Omnibook 450B) when I build in the ACPI system 
(either as module or into the kernel) the system hangs on boot.  It does 
this at the point of activating ACPI.  I enabled the debug mode and my 
laptop dies at:

ACPI Namespace successfully loaded at root c028a6c0
ACPI: Core Subsystem version [20010831]
Executing device _INI methods:.....................

(that's 21 '.'s).

Is there anything else I can do to help track down what's causing this and 
resolve it?

I'm not on the list (though I should start getting the daily digest as of 
today) so you'll need to CC me if you want me to see anything.

--
Rob  |  Please ask questions the smart way:
                http://www.tuxedo.org/~esr/faqs/smart-questions.html

    Please don't CC me on anything sent to mailing lists or send
        me email directly unless it's a privacy issue, thanks.


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

