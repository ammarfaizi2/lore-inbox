Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131343AbRCHMKC>; Thu, 8 Mar 2001 07:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRCHMJw>; Thu, 8 Mar 2001 07:09:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62731 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131343AbRCHMJn>; Thu, 8 Mar 2001 07:09:43 -0500
Subject: Re: Linux 2.4.2ac14
To: ramsy@10art-ni.co.jp (Keitaro Yosimura)
Date: Thu, 8 Mar 2001 12:12:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010308141636.C2DE.RAMSY@10art-ni.co.jp> from "Keitaro Yosimura" at Mar 08, 2001 02:20:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14azH0-0002qi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >The next patch would create the file `include/linux/hdlc.h',
> >which already exists!  Assume -R? [n] n
> >Apply anyway? [n] y
> >patching file `include/linux/hdlc.h'
> >Patch attempted to create file `include/linux/hdlc.h', which already exists.
> >Hunk #1 FAILED at 1.
> >1 out of 1 hunk FAILED -- saving rejects to include/linux/hdlc.h.rej
> 
> must remove before patching? or ignore it?

That looks like you applied ac14 over ac13 or to 2.4.3pre not to 2.4.2
