Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317674AbSGZKnd>; Fri, 26 Jul 2002 06:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317671AbSGZKnb>; Fri, 26 Jul 2002 06:43:31 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11648 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317673AbSGZKna>;
	Fri, 26 Jul 2002 06:43:30 -0400
Date: Fri, 26 Jul 2002 12:46:42 +0200
From: Pavel Machek <pavel@elf.ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Albert Cranford <ac9410@bellsouth.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/9] 2.5.6 lm_sensors
Message-ID: <20020726104640.GD279@elf.ucw.cz>
References: <3D381CD1.6A0B9909@bellsouth.net> <1027130877.14314.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027130877.14314.6.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The i2c & lm_sensors group would like to submit these 9
> > patches from our stable 2.6.3 package.
> 
> 
> Does this stuff still destroy thinkpads so badly they have to go back to
> ibm for a non warranty repair ? Nobody seems willing to provide straight
> answers, and I think they must be addressed before we merge such code

Someone should write windows virus killing thinkpads -- to get some
nice publicity for IBM. Hardware that commits suicide on i2c access is
just not nice.

Hmm, perhaps bugtraq article with "severe DoS on thinkpad hardware"
would be nice, too.
									Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
