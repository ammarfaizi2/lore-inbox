Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVE0NLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVE0NLd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVE0NLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:11:33 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:47566 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S262473AbVE0NKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:10:17 -0400
Message-ID: <42971C0E.9030504@cs.aau.dk>
Date: Fri, 27 May 2005 15:09:34 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux for Mobile phones and PDAs [long]
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

These last weeks have been particularly busy in the wonderful world
of consumer electronics. Linux seems to be more and more considered as a
solution for these companies !

Since approximately two years, the CELF (Consumer Electronics Linux
Forum)  (http://www.celinuxforum.org/) try to harden the link between
the Linux community and companies such as Sony, IBM, Nokia, PalmSource,
and others (http://www.celinuxforum.org/MemberOrganization.htm). This
non profit organization
(http://www.linuxdevices.com/news/NS2163552454.html) is trying (among
other things and as far as I understand it) to identify the weakness of
Linux in matter of consumer electronics and to push for strengthening
Linux in this very precise topics. Some of the results of the CELF that
have been presented in its first conference can be found here:
http://www.linuxdevices.com/articles/AT9266731500.html.

Aside from that, and very recently several companies have been starting
to make some interesting announcement. For example, on May the 24th,
PalmSource opened the bal by saying: "Linux is our
platform for the future"
(http://www.linuxdevices.com/news/NS4835848451.html). It seems that the
PalmOS kernel has been quite disappointing in matter of resources
management and Symbian was not an alternative to it. Moreover, Palm
seems to target the 3G market and need a much quicker development model
with more involved developers. So, Linux was probably one logical choice
as they joined the CELF recently
(http://www.linuxdevices.com/news/NS8402137834.html).

Again, this week, during the LinuxWorld event in New-York, Nokia
unveiled its first tablet-PC (Nokia 770, http://www.nokia.com/770)
which is running under a 2.6.x kernel
(http://hardware.slashdot.org/hardware/05/05/25/139202.shtml?tid=100,
http://www.linuxdevices.com/news/NS5409534614.html) ! The day after,
Nokia announce that they will release patents for Open Source
development (as IBM did)
(http://yro.slashdot.org/yro/05/05/25/1827259.shtml?tid=155&tid=106).
But, that's not all of it, it seems that the making of the 770 has
involved quite a lot of the people of the Open Source community whom
were ask to keep a 'low profile' until the product will be released
(http://mail.gnome.org/archives/gnome-multimedia/2005-May/msg00021.html).
So, indeed, Nokia has been funding several Open Source projects for the
last few months without advertising it too much. From my (poor)
knowledge here are some of the companies Nokia did fund for getting its
770 ready:

- Imendio (Gossip, Blam, Planner, DevHelp)
http://www.imendio.com/
http://www.imendio.com/press/show/7

- Fluendo (GStreamer, Flumotion, Pitivi, ...)
http://www.fluendo.com/

- Kernel Concepts (Contribution to Maemo)
http://www.kernelconcepts.de/
http://oss.kernelconcepts.de/

- OpenedHand (Matchbox window management software)
http://www.o-hand.com/
http://www.linuxpr.com/releases/7833.html

On the top of that, the development platform for the device is totally
free. To my knowledge (I'm sure I'm missing something), it's the first
time that a company in consumer electronics of the size of Nokia release
a complete Open Source development platform:
http://www.maemo.org/
http://www.maemo.org/platform/docs/tutorials/Maemo_tutorial.html
http://www.scratchbox.org/
http://www.linuxdevices.com/news/NS3716070830.html
http://www.linuxdevices.com/news/NS8608661173.html

Speaking about the hardware, it's an ARM9 (TI-OMAP) and it's relatively
cheap to get on of these (around 400$/320¤ including the LCD (optional)).

OMAP Starter Kits:
http://focus.ti.com/docs/general/splashdsp.jhtml?&path=templatedata/cm/splashdsp/data/omap5912_osk
http://oskfordummies.hp.infoseek.co.jp/
http://tree.celinuxforum.org/CelfPubWiki/FlashRecoveryUtility
http://www.ti-estore.com/Merchant2/merchant.mvc?Screen=CTGY&Category_Code=dStartKit

Still not convinced ? Too expensive... Well, Nokia is offering 500 of
these 770 for 99¤ per unit to Open Source developers. Take you chance:
http://maemo.org/news/25052005.html

Well, all this for what ???

My guess is that Nokia is trying to test the Open Source for its phones.
The 770 is just a first try out. They have some benefit to do so, and we
all have some benefit also... It's a win/win game if we can cooperate
under appropriate agreements (maybe there is a footnote in very small
characters somewhere, but I missed it totally). My big hope is that if
the Open Source community give a good feed back to them, other companies
which have already one foot in the door, will suddenly want to get in
and focus much more on Linux for their PDA or mobile phone.

So, if these links and this e-mail can make several of you at least
trying out to develop for PDA or mobile phones (getting hardware,
writing documentations, bug fixing, patches, new code, ...), this would
be great ! :)


Regards
-- 
Emmanuel Fleury

Assistant Professor          | Office: B1-201
Computer Science Department, | Phone:  +45 96 35 72 23
Aalborg University,          | Mobile: +45 26 22 98 03
Fredriks Bajersvej 7E,       | E-mail: fleury@cs.aau.dk
9220 Aalborg East, Denmark   | URL: www.cs.aau.dk/~fleury
