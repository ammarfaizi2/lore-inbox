Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267428AbRGQVwg>; Tue, 17 Jul 2001 17:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbRGQVw0>; Tue, 17 Jul 2001 17:52:26 -0400
Received: from dragonfire3.delta.com ([205.174.22.22]:16016 "EHLO
	satlmsghub03.delta-air.com") by vger.kernel.org with ESMTP
	id <S267428AbRGQVwS>; Tue, 17 Jul 2001 17:52:18 -0400
Message-ID: <BDEE1F50C0C6D411BBB600204840D7B40124F181@satlrccdmrus25.delta-air.com>
From: "Dominick, David" <David.Dominick@delta.com>
To: "'John Weber'" <weber@nyc.rr.com>, linux-kernel@vger.kernel.org
Subject: RE: sound?!?!!?
Date: Tue, 17 Jul 2001 17:52:16 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when running sndconfig I get:
/lib/modules/2.4.6/kernel/drivers/sound/sound.o: unresolved symbol
request_module

-----Original Message-----
From: John Weber [mailto:weber@nyc.rr.com]
Sent: Tuesday, July 17, 2001 3:39 PM
To: linux-kernel@vger.kernel.org; Dominick, David
Subject: Re: sound?!?!!?


Dominick, David wrote:

> I am having problems with the opl3sa2 driver for yamaha sound card on my
> toshiba running kernel 2.4.6
> 
> HELP!!!

I am running kernel 2.4.6 on a toshiba satellite 225CDS and toshiba 
tecra 8000 (both use OPL3sa2 driver), and sound is working well.  What 
exactly do you have problems with?  Is this a redhat problem (a problem 
with sndconfig)?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
