Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTJSI0g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTJSI0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:26:36 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25861
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262111AbTJSI02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:26:28 -0400
Date: Sun, 19 Oct 2003 01:21:19 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
cc: "'Norman Diamond '" <ndiamond@wta.att.ne.jp>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>,
       "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>,
       "'nikita@namesys.com '" <nikita@namesys.com>,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: RE: Blockbusting news, results are in
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com>
Message-ID: <Pine.LNX.4.10.10310190120330.15306-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric,

That is what DCO is and we both know what that issue will bring to the
table.

Andre Hedrick
LAD Storage Consulting Group

On Sun, 19 Oct 2003, Mudama, Eric wrote:

> 
> > Does anyone need more?
> 
> Why don't you ask your friends at Toshiba whether that model supports
> automatic reallocation, and if it does, how to enable it?
> 
> Since it isn't in the T13 ATA spec, I am assuming the ability to toggle that
> feature is very vendor-specific.  Pretty sure all Maxtors from at least the
> last year ship with that sort of reallocation enabled, and probably the last
> 4-5 years.
> 
> > We do not know if Toshiba is the only maker whose firmware
> > refuses to reallocate bad blocks when permanent errors are
> > detected, because the makers aren't saying.
> 
> What would you like "us disk makers" to say?  The drives I play with at work
> happily reallocate on the fly all the time. (when I whack them with a
> screwdriver and cause scratches on the media, that is)
> 
> > By the way, Toshiba's US subsidiary has indications on their
> > web site that they provide warranty service on their products,
> > but that they have reduced the warranty period from three years
> > to one year.  This was a smart move by Toshiba's US subsidiary.
> 
> Yes, it saves us a lot of money every year, and lets us sell you each drive
> for a few dollars cheaper.  My understanding is that the #1 cost issue is
> the fact that to warranty a product legally in the USA, you need to maintain
> a certain amount of product to handle replacement drives, long after they
> stop being shipped.  Reducing our warranty inventory to some fraction of 1
> year's volume (~55M drives) from some fraction of 3 year's volume (~160M
> drives) is a significant amount of product we don't have to "eat".
> (Remember, 3 year old drives, that we no longer need to hold on to for
> warranty purposes, are near-worthless in the consumer market)
> 
> If every other part of your computer is warrantied for 1 year, why should
> disk drives alone in the cheapest OEM systems carry 3 year warranties?  BTW,
> you're welcome to buy "premium" drives with 3-year or 5-year warranties.  (3
> on most vendor's high end ATA products, and 5 years on most SCSI products)
> In most cases these premium warranties will only cost you $5-$10.  (This is
> based simply on the rough price delta between our DiamondMax Plus9 200GB and
> our MaxLine II 200GB, which are basically the same drive with different
> warranties)
> 
> > If their disk drives start to develop bad blocks after two
> > years, then customers don't discover how bad Toshiba's firmware
> > is until two years have passed, and now they can't even make
> > claims to get firmware fixed.
> 
> What do you want "fixed" in the firmware?  It is 1000x cheaper to just send
> you a replacement drive from the current product line.  By the time 3 years
> have passed (2 years beyond a 1 year warranty), our factory isn't even
> capable of reprocessing the disk drive you hold in your hands, since we wind
> up retooling chunks of it every few months to make way for
> bigger/faster/quieter/cheaper disk drives.
> 
> About 2.5 years ago, Maxtor's largest drive was 60GB... 15GB/head.  Now
> we're shipping 250GB drives with 6 heads also... ~42GB/head, almost triple
> the capacity, and in a few months we'll be doing a chunk better.
> 
> The only two parts in common between those two drives is the molex power
> connector.
> 
> > Toshiba's head office is even smarter.  In Japanese they refuse
> > entirely to provide warranty service to end users.  Customers
> > have to send defective disk drives back up through the sales channel.
> 
> I guess my suggestion is don't buy Toshiba.  Research support options before
> you buy.
> 
> > Well, lucky customers who bought the disk drive as part of a notebook
> > computer probably get one year's warranty from the vendor of the
> > notebook computer, so if they're lucky enough to learn about Toshiba's
> > firmware within a year then they can send their entire computer back
> > for some length of time to get warranty service.
> 
> See above.
> 
> > But anyone who went to Akihabara and bought the drive by itself from a
> > parts store, the store probably offers one week or one month to
> > replace a failing drive if it was dead on arrival.  In these cases
> > a customer who learns about Toshiba's firmware after two weeks or five
> > weeks gets screwed.
> 
> Don't buy drives from bargain basement shops.  Buy from trusted retailers,
> or direct from the manufacturer.  That you bought from a place that probably
> didn't even stock retail packages in shock-resistant packaging is stupid.
> 
> > But Toshiba isn't the only maker who isn't saying how bad their
> > firmware is.  We need those bad block lists.  They are as
> > necessary as they ever were.
> 
> We're not saying our firmware is bad because frankly, I think it is rather
> decent, and getting better every single product we release.  Given that the
> disk drive is probably the most complex piece of machinery in your home, I
> think they do pretty well all things considered.
> 
> I still don't understand why your Toshiba engineer friends couldn't help you
> beyond listening to the drive bounce off the crash stop.
> 
> (BTW, if the drive is clunking because it can't acquire at a certain
> location, odds are that more than just the user data at that sector is a
> problem.  Your testing doesn't indicate that, but I'd be suspicious
> personally.)
> 
> --eric, speaking for myself not Maxtor of course
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

