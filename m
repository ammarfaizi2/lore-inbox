Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311848AbSCNW5a>; Thu, 14 Mar 2002 17:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311851AbSCNW5T>; Thu, 14 Mar 2002 17:57:19 -0500
Received: from [63.204.6.12] ([63.204.6.12]:33202 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S311848AbSCNW5I>;
	Thu, 14 Mar 2002 17:57:08 -0500
Date: Thu, 14 Mar 2002 17:56:45 -0500
From: "Mark Frazer" <mark@somanetworks.com>
To: Ben Greear <greearb@candelatech.com>
Cc: Robert Love <rml@tech9.net>, Larry McVoy <lm@bitmover.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 and BitKeeper
Message-ID: <20020314175645.A30883@somanetworks.com>
In-Reply-To: <Pine.LNX.4.21.0203140141450.4725-100000@freak.distro.conectiva> <3C904437.7080603@candelatech.com> <20020313224255.F9010@work.bitmover.com> <3C90E994.2030702@candelatech.com> <1016130404.4289.5.camel@phantasy> <3C90EEB9.5050007@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C90EEB9.5050007@candelatech.com>; from greearb@candelatech.com on Thu, Mar 14, 2002 at 11:40:57AM -0700
X-Message-Flag: Lookout!
Organization: Detectable, well, not really
X-Fry-1: Drugs are for losers. And hypnosis is for losers with big weird
X-Fry-2: eyebrows.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ben Greear <greearb@candelatech.com> [02/03/14 13:46]:
> Ahh, that did fix the problem.  It must be configured differently
> where I work, because I do not have to do the bk -r co command there.

You probably have
checkout: get
in your BitKeeper/etc/config file

