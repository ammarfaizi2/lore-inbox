Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTJRHoB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 03:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbTJRHoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 03:44:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4315 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261471AbTJRHn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 03:43:58 -0400
Date: Sat, 18 Oct 2003 09:42:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: John Bradford <john@grabjohn.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Message-ID: <20031018074223.GN1659@openzaurus.ucw.cz>
References: <33a201c39174_2b936660_5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492_bc5307c0_3eee4ca5@DIAMONDLX60> <20031017102436.GB10185@bitwizard.nl> <200310171049.h9HAnBbO000594@81-2-122-30.bradfords.org.uk> <m3zng0yun9.fsf@defiant.pm.waw.pl> <200310171935.h9HJZaLm002335@81-2-122-30.bradfords.org.uk> <m37k33igui.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m37k33igui.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> BTW: Hard drives apparently use more sophisticated algorithms,
> involving measuring head signal level even when there is no problem
> reading the data, and eventually remapping a sector on read before the
> information is lost.
> 

Which means cat /dev/hda > /dev/null makes sense in
cron.weekly...
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

