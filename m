Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWBXH1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWBXH1E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWBXH1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:27:04 -0500
Received: from styx.suse.cz ([82.119.242.94]:63893 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750809AbWBXH1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:27:02 -0500
Date: Fri, 24 Feb 2006 08:27:15 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: i386 AT keyboard LED question.
Message-ID: <20060224072715.GA8088@suse.cz>
References: <200602202003.26642.nick@linicks.net> <20060220202441.GB31272@suse.cz> <Pine.LNX.4.61.0602240816130.16363@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602240816130.16363@yvahk01.tjqt.qr>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 08:17:19AM +0100, Jan Engelhardt wrote:
> > 
> >Some old notebooks forget them on, which makes the keyboard unusable -
> >you get '4' instead of 'u', etc.
> >
> Not only old notebooks, but all 84-key keyboards with Num 
> functionality are affected AFAICS.
 
If we forced the LED to ON everytime, they would be. If we used the BIOS
setting (by peeking into the BIOS area), then only a few machines would
have a problem - the BIOS defaults are often either correct or
correctable by the user.

-- 
Vojtech Pavlik
Director SuSE Labs
