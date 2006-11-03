Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753338AbWKCQLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbWKCQLD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbWKCQLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:11:01 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47829 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1753338AbWKCQLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:11:00 -0500
X-Sasl-enc: 8EMhBNMFVZahY17Lfg2pnfuHpbYNgud+0xKU8rNbUkBu 1162570260
Date: Fri, 3 Nov 2006 13:10:48 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Jean Delvare <khali@linux-fr.org>,
       davidz@redhat.com, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061103161047.GC4257@khazad-dum.debian.net>
References: <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com> <znLIYxER.1162453921.3011900.khali@localhost> <454A306C.3050200@tmr.com> <000b01c6feb4$c340a580$0732700a@djlaptop> <20061103132340.GB4257@khazad-dum.debian.net> <001b01c6ff53$41a21eb0$0732700a@djlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001b01c6ff53$41a21eb0$0732700a@djlaptop>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Nov 2006, Richard B. Johnson wrote:
> I'm not sure anybody actually embeds a micro. There is some chip,

I'd have to crack open a ThinkPad battery to know for sure, as well.  That's
why I used "some sort of embedded controller"...  I am operating on
second-hand data.

Still, stuff like http://focus.ti.com/docs/prod/folders/print/bq20z90.html
gives me some hope the battery packs have some good stuff in it.

> originally make by National, that was supposed to monitor the battery
> state. I know that I have used five laptops so far and have never been
> able to obtain any intellegent operation. They just shut down when they
> feel like it.  They do go to "suspend" mode to save power as well, always
> at the most inopertune moment.

Try a ThinkPad, they are a bit better than that :-)   Of course, you have to
disable (or properly configure) stuff that tries to outguess you and are not
really enabled to talk to ThinkPad specifics like what comes with KDE and
GNOME, if you don't want to get surprise suspends.

I am not sure how better a recent ThinkPad (T42 or newer) behaviour would be
by your standards, but still...

> Maybe the "ThinkPad" actually has some intellegence within. The cost of
> the batteries only reflects the cost of defending lawsuits <grin> and not
> the cost of its components.  Batteries made in China seem to become
> "excited" at inopertune times.

Well, all of mine come with "made in Japan" seals from Sanyo.  I sure hope
this means the cells themselves are not from some third-party with shoddy
quality control and manufacturing processes.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
