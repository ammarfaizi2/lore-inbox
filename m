Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268170AbTAKW15>; Sat, 11 Jan 2003 17:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268167AbTAKW15>; Sat, 11 Jan 2003 17:27:57 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:33701 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S268172AbTAKW14>;
	Sat, 11 Jan 2003 17:27:56 -0500
Date: Sat, 11 Jan 2003 23:36:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rob Wilkens <robw@optonline.net>
Cc: Kurt Garloff <kurt@garloff.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Nvidia and its choice to read the GPL "differently"
Message-ID: <20030111233633.A17042@ucw.cz>
References: <7BFCE5F1EF28D64198522688F5449D5A03C0F4@xchangeserver2.storigen.com> <1042250324.1278.18.camel@RobsPC.RobertWilkens.com> <20030111020738.GC9373@work.bitmover.com> <1042251202.1259.28.camel@RobsPC.RobertWilkens.com> <20030111021741.GF9373@work.bitmover.com> <1042252717.1259.51.camel@RobsPC.RobertWilkens.com> <20030111214437.GD9153@nbkurt.casa-etp.nl> <1042322012.1034.6.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1042322012.1034.6.camel@RobsPC.RobertWilkens.com>; from robw@optonline.net on Sat, Jan 11, 2003 at 04:53:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 04:53:33PM -0500, Rob Wilkens wrote:
> On Sat, 2003-01-11 at 16:44, Kurt Garloff wrote:
> > You're new to Linux, aren't you?
> > Or terribly presumptous.
> 
> A little of both, but not too much of either.
> 
> I'd say "New to linux" but I've been using it on and off since 1995 or
> earlier.
> 
> I'd say terribly presumptuous, but I don't think it is presumptuous to
> say that if there are many patches (bug fixes, mostly) coming in that
> the code that was originally there was of questionable quality.

Very interesting idea. But not correct.

The reason is code rot(*). You have never to stop maintaining and patching
and fixing the code to keep it working. A perfectly good and clean code,
if you don't touch it, becomes crusty and smelly over time(**). This is why
the number of patches daily entering the kernel is actually a sign of good
overall code quality. ;)

(*)
	http://www.tuxedo.org/~esr/jargon/html/entry/software-rot.html
	http://www.tuxedo.org/~esr/jargon/html/entry/bit-rot.html

(**)
	One of the reasons for this is that the hardware changes over
	time. Another is that the requirements of what it is expected to
	do change over time. And yet another is that due to the above
	changes the rest of the code gets updated and the parts that
	were not touched do not interoperate properly any more.

Huh. And now I'll be getting all the e-mails following in this thread.

-- 
Vojtech Pavlik
SuSE Labs
