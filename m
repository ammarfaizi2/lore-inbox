Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131296AbRA2JUm>; Mon, 29 Jan 2001 04:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131817AbRA2JUb>; Mon, 29 Jan 2001 04:20:31 -0500
Received: from mail15.bigmailbox.com ([209.132.220.46]:39436 "EHLO
	mail15.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S131296AbRA2JUV>; Mon, 29 Jan 2001 04:20:21 -0500
Date: Mon, 29 Jan 2001 01:20:15 -0800
Message-Id: <200101290920.BAA28321@mail15.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [24.5.157.48]
From: "Quim K Holland" <qkholland@my-deja.com>
To: Dylan_G@bigfoot.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: More on the VIA KT133 chipset misbehaving in Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "DG" == Dylan Griffiths <Dylan_G@bigfoot.com> writes:

DG> The VIA KT133 chipset exhibits the following bugs under Linux
DG> 2.2.17 and 2.4.0:
DG> 1) PS/2 mouse cursor randomly jumps to upper right hand corner
DG> of screen and locks for a bit
DG> 2) Detects a maximum of 64mb of ram, unless worked around by the
DG> "mem=" switch
DG> 3) The clock drifts slowly (more so under heavy load than light
DG> load), leaking time.

I am not a guru, but AOpen AK73PRO which uses VIA KT133 does not
show any of these symptoms that you describe (I cannot be sure
about #3 since I run ntp).  You may want to make your hardware
description a bit more specific to help gurus to help you...


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
