Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRBRL6W>; Sun, 18 Feb 2001 06:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132867AbRBRL6C>; Sun, 18 Feb 2001 06:58:02 -0500
Received: from limes.hometree.net ([194.231.17.49]:11884 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S132807AbRBRL5x>; Sun, 18 Feb 2001 06:57:53 -0500
To: linux-kernel@vger.kernel.org
Date: Sun, 18 Feb 2001 11:54:27 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <96od5j$ja6$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <96lrau$dcd$1@forge.intermeta.de>, <20010217230349.A4561@convergence.de>
Reply-To: hps@tanstaafl.de
Subject: Re: [LONG RANT] Re: Linux stifles innovation...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

leitner@convergence.de (Felix von Leitner) writes:

>Thus spake Henning P . Schmiedehausen (hps@intermeta.de):
>> "If a company does not write a driver which works on all hardware
>>  platforms in all cases and gives us the source, then it is better,
>>  that the company writes no drivers at all."

>> "If I can't force a company to write a driver for everyone, then I
>>  don't want to write them any driver at all."

>> IMHO you're like a spoiled kid: "If I can't have it, noone should have it".

>Henning, what is the matter with you?

The matter with me is: "Vendors AAA ships its hardware product with a
driver for i386/Linux". The driver may be closed source, but at least
there _is_ a driver. Russell now says: "This is bad, because I can't use
the driver for my ARM box. So the vendor should ship no driver at
all. This is better than a i386-only driver". 

I say "I'm happy that there is _ANY_ driver at all. Because the vendor
has recognized the importance of Linux at least on i386. And if they
did this and they see, that they _can_ get market share, maybe they
will start thinking about releasing for other architectures, too. Or
even release the source to their driver".

And if someone wants a driver for the hardware of vendor AAA on ARM
and vendor AAA does decide _not_ to release the product for ARM, it is
their right to do so. 

And Russell may still approach AAA to release an ARM driver, too. Or
buy a product from BBB, which does support ARM with either a
vendor-supported close source driver or an open source driver.

Someone approached Legato to release a MIPS/Linux version of their
backup client. Maybe they even paid for the port. And now, everyone
can get this client from the Legato website. It is still closed
source, but still, everyone that has a MIPS/Linux box benefited from
this. 

>I bought the hardware.  Why should I pay for the driver?

If the hardware is "NOT SUPPORTED BESIDES LINUX/i386" and you have an
ARM, the solution is simple: DON'T BUY IT. VOTE WITH YOUR MONEY. If
Linux/ARM starts becoming a sigificant part of the market share,
vendor AAA will either lose to vendor BBB or release a driver for ARM.

>Please state your intentions.  Why would you want to split the Linux
>user base into people who pay companies to screw them (I get a driver
>for hardware I already paid for, but the driver will work with exactly
>one kernel version on one hardware) and people who think they deserve
>support when they buy hardware?

If you buy a hardware and on the box is stated "Supported on Windows,
MacOS and Linux/i386" and you have none of these platforms, why buy
it? If you buy it and then start complaining "it is not vendor-
supported on Linux/ARM", it is your fault and not the fault of the
vendor. If the vendor puts a second box next to the hardware box on
the shelves, which just contains a CD-ROM with a binary only driver
for Linux/ARM and sells this box for $99, it's their right to do
so. And Russell can buy a vendor supported driver for Linux/ARM.

>Why do we even have to discuss drivers?
>A company that actively hinders developing a good driver with patents,
>NDAs or other legal crap does not deserve my money.  If you throw your
>money at such people, you deserve everything you get.

That's exactly my point. Nice to see, that we agree. ;-) See
above. Vote with your money. But IMHO it's better to get
vendor-supported drivers for Linux/i386, than no driver at
all. Because if these drivers do not work, I _can_ call the company
and complain.

And I actively _DON'T_ want _YOU_ to decide what _I_ want. If I can
get a driver for the hardware XXX that I need for a project and vendor
AAA sells me a driver for this product on Linux only for a certain
platform, kernel version and distribution, it is _MY_ _PERSONAL_
_DECISION_ to still buy this driver or not. I don't want anyone to
tell me "you must not do this, because it's bad". If it's bad or not,
please let me decide. I'm old enough to decide for myself.

I WANT THE CHOICE. If I have no choice, I buy the product on another
platform.

And you can be sure, I will not come running to LKM to complain and
demand support.

And you can even sue if you're in Germany and the driver does not work
as stated on the box("Erfüllung zugesicherter Eigenschaften, Nach-
besserung oder Wandlung").

	Regards
		Henning

P.S.: I consider "configuring a mailer so that it does not accept mail
from a sender" neither good style nor "das letzte Wort" in a discussion. 
It is IMHO a sign of weakness and inability to discuss on an objective
base. It is more like "I don't like your opinion, so I censor you".
Discussion, Microsoft-style.

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
