Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVJDMyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVJDMyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVJDMyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:54:06 -0400
Received: from free.hands.com ([83.142.228.128]:62597 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932419AbVJDMyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:54:05 -0400
Date: Tue, 4 Oct 2005 13:53:54 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051004125354.GO10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net> <20051003005400.GM6290@lkcl.net> <Pine.LNX.4.58.0510021800240.19613@shell2.speakeasy.net> <20051003015302.GP6290@lkcl.net> <20051003181924.GB8011@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003181924.GB8011@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, so if we guess it might take 10 masks per processor type over it's
> life time as they change features and such, that's still less than 1% of
> the cost of the FAB in the first place.  I agree with the person that
> said intel/AMD/company probably don't care much, as long as their
> engineers make really darn sure that the mask is correct when they go to
> make one.
 
 you elaborate, therefore, on my point.

 anyone else, therefore, cannot hope to compete or even enter the
 market, at 90nm.

 which is why the first VIA eden processors maxed out at 800mhz (i'm
 guessing they were a 0.13micron and therefore 2.5 volts)

> >  ... why do you think intel is hyping support for and backing
> >  hyperthreads support in XEN/Linux so much?
> 
> Ehm, because intel has it and their P4 desperately needs help to gain
> any performance it can until they get the Pentium-M based desktop chips
> finished with multiple cores, and of course because AMD doesn't have it.
> Seem like good reasons for intel to try and push it.
 
 you lend weight to my earlier points: the push is to
 drive the engineers towards less gates on the excuse of
 cart-before-horsing the market with their "performance / watt"
 metrics, such that if 0.65nm comes off it's less painful
 and not too much of a jump, and they aim for more parallel
 processing (multiple cores).

 current  : 200 million gates with 90nm at 1.65 volt
 estimated: 40 million gates with 65nm at 1.1 volt
 estimated: 1 million gates with 45nm at 0.9 volt.

 the "off" voltage of a silicon germanium transistor is 0.8 volts.

 at 45nm the current leakage is so insane that the heat
 dissipation, through the oxide layer which covers the chip,
 ends up blowing the chip up.

 trouble.

 l.

