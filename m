Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264453AbRFIKWZ>; Sat, 9 Jun 2001 06:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264456AbRFIKWP>; Sat, 9 Jun 2001 06:22:15 -0400
Received: from elin.scali.no ([195.139.250.10]:24840 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S264453AbRFIKWH>;
	Sat, 9 Jun 2001 06:22:07 -0400
Message-ID: <3B21F856.D5A2DF6@scali.no>
Date: Sat, 09 Jun 2001 12:20:06 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "L. K." <lk@Aniela.EU.ORG>
CC: Bill Pringlemeir <bpringle@sympatico.ca>,
        "Michael H. Warfield" <mhw@wittsend.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Chris Boot <bootc@worldnet.fr>,
        mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
In-Reply-To: <Pine.LNX.4.21.0106091257380.5416-100000@ns1.Aniela.EU.ORG>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"L. K." wrote:
> I haven't encountered any CPU with builtin temperature sensors.
> 
Eh, all Pentium class cpus have a build in sensor for core temperature (I believe Athlons
too). It's just the logic which is outside in form of a A/D converter connected to a I2C
bus.

Regards,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
