Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129291AbRB1V4g>; Wed, 28 Feb 2001 16:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129292AbRB1V42>; Wed, 28 Feb 2001 16:56:28 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:30468 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129291AbRB1V4J>;
	Wed, 28 Feb 2001 16:56:09 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Michal Jaegermann <michal@harddata.com>
Date: Wed, 28 Feb 2001 22:54:15 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4 kernels - "attempt to access beyond end of device"
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <C157EB0697@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Feb 01 at 13:46, Michal Jaegermann wrote:
> I think that I found what gives me a hell with this box and it
> looks like that this not Linux at all.  Once again, this is Athlon
> K6 on Asus AV7 mobo and "Award Advanced ACPI BIOS" version 1005C.

K7 on A7V, I believe...

> I have more checks to make before I will be fully satisfied but
> this looks like it.
...
> System Performance Setting [Optimal, Normal]
...

Try BIOS 1006. AFAIK 1005D changed some VIA values for 'optimal'.
And 1006 contains newer Promise BIOS - but I did not notice any difference:
Windows98 still do not boot if I connect harddisk to /dev/hdh :-(
But Linux works fine...
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
