Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130604AbQKORSd>; Wed, 15 Nov 2000 12:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbQKORSX>; Wed, 15 Nov 2000 12:18:23 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:1043 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S130604AbQKORSP>;
	Wed, 15 Nov 2000 12:18:15 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Tigran Aivazian <tigran@veritas.com>
Date: Wed, 15 Nov 2000 17:47:28 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: test11-pre5 breaks vmware
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <CF021B54DF0@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 00 at 1:59, Tigran Aivazian wrote:

> You probably noticed this already but I just wanted to bring it to your
> attention that /usr/bin/vmware-config.pl script needs updating since the
> flags in /proc/cpuinfo is now called "features" so it otherwise fails
> complaining that my 2xP6 has no tsc. Trivial change but still worthy of
> propagating into your latest .tar.gz file for 2.4.x

Oh. I did not compiled 11-test5, as G450 finally arrived ;-) OK,
I'll release patch for vmware, as I cannot stop kernel developers
from changing field names :-)
                                       Thanks for reporting,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
