Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSIIMVV>; Mon, 9 Sep 2002 08:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSIIMVV>; Mon, 9 Sep 2002 08:21:21 -0400
Received: from web20803.mail.yahoo.com ([216.136.226.192]:47520 "HELO
	web20803.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317232AbSIIMVU>; Mon, 9 Sep 2002 08:21:20 -0400
Message-ID: <20020909122604.10354.qmail@web20803.mail.yahoo.com>
Date: Mon, 9 Sep 2002 05:26:04 -0700 (PDT)
From: Atish Datta Chowdhury <adattachowdhury@yahoo.com>
Subject: question about machne checksum errors
To: linux-kernel@vger.kernel.org
Cc: adattachowdhury@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
                Thanks in advance for any
clarifications.

                I was trying to analyze a few machine 
checksum errors,  and obtained a lot of valuable
information in the archive,  including a 
referrence to Dave Jones' tool,  parsemce. Thanks !

              The servers that we get these occasional
errors on, are mostly dual AMD boxes (MP 1800s, 
typically) running 2.4.18.  Are the decoding rules, 
present in Intel's IA-32 MCA documentation, applicable

on these servers ? As detailed in Intel's 
Software Developer's Manual, looks like  it is not 
mandatory for an IA-32 compliant system to follow the 
decoding rules on all the fields in the machine status

registers (e.g the ones that indicate Uncorrectable 
ECC errors)..

             Appreciate any help regarding this.

-thanks,
Atish

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
