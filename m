Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286383AbRLTVSF>; Thu, 20 Dec 2001 16:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286385AbRLTVRz>; Thu, 20 Dec 2001 16:17:55 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:33547 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S286383AbRLTVRm>;
	Thu, 20 Dec 2001 16:17:42 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: esr@thyrsus.com
Date: Thu, 20 Dec 2001 22:17:16 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Configure.help editorial policy
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <C8FDA4E01E4@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Dec 01 at 14:27, Reid Hekman wrote:
> > If there is a clear consensus from lkml, I will be happy to back
> > out this change.  Perhaps this terminological standard does not
> > meet a real need, perhaps it will be rejected by most engineers and 
> > deserves to wither on the vine.  It's happened before.
> 
> I'd vote for that.

Well, I vote for that too. And I'm _for_ using KiB, MiB, GiB with all
my fingers. When you buy computer memory, it is always in ?iB units
(as nobody sane can upgrade computer equipped with 512000000 bytes 
memory stick with some additional memory) but in all other cases (in-core 
process size, hdd size, file size) it is very unclear what you mean.
Yes, error is only 2% - but if everyone around can give me 2% of
his HDD capacity, I think that I'm going to be very happy.

Yes, it is new prefix, but everything is sometime new. When computers
had 64KB of memory, there was capital K as 1024 bytes. But then computer
grew up, and already used letter 'M' was used as 2^20. It was serious 
mistake, and as using same expression for different prefixes is unacceptable
(at least for me), and I do not think that we are going to use 1GdHz CPUs, 
we are going to use computers with 4GiB of memory.
                                        Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
