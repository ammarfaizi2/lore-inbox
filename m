Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031182AbWKPL4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031182AbWKPL4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 06:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031181AbWKPL4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 06:56:05 -0500
Received: from legolas.otaku42.de ([217.24.0.78]:9194 "EHLO legolas.otaku42.de")
	by vger.kernel.org with ESMTP id S1031179AbWKPL4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 06:56:02 -0500
Message-ID: <2983.194.45.26.221.1163678143.squirrel@webmail.otaku42.de>
In-Reply-To: <40f31dec0611160207hcfd5069hc7763d1e99cccd7c@mail.gmail.com>
References: <20061115031025.GH3451@tuxdriver.com> 
    <20061115192054.GA10009@tuxdriver.com> <1163619541.19111.6.camel@dv> 
    <200611152102.26681.mb@bu3sch.de> <455BF908.6090006@otaku42.de>
    <40f31dec0611160207hcfd5069hc7763d1e99cccd7c@mail.gmail.com>
Date: Thu, 16 Nov 2006 12:55:43 +0100 (CET)
Subject: Re: [Madwifi-devel] ANNOUNCE: SFLC helps developers assess ar5k 
     (enabling free Atheros HAL)
From: "Michael Renzmann" <madwifi@nospam.otaku42.de>
To: "Nick Kossifidis" <mickflemm@gmail.com>
Cc: "Michael Buesch" <mb@bu3sch.de>, "Pavel Roskin" <proski@gnu.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       madwifi-devel@lists.sourceforge.net, lwn@lwn.net,
       "John W. Linville" <linville@tuxdriver.com>
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> Just in case you want to experiment, i have a working port of ar5k
> that works on madwifi-old before the BSD - HEAD merge...

Just to mention it: madwifi-old is no longer officially supported, and is
a bad ground to start working on IMO (at least for anything that goes
beyond a quick test).

Interested parties should start from trunk instead (which is at r1809 as
of now, by the way), or, even better, from the DadWifi branch. However, it
will require some work to get the OpenHAL working in either of them. I
suggest that related questions and discussions should be directed to the
madwifi-devel list, since they might be of little interest (yet) on netdev
or lkml.

The MadWifi project is happy to provide resources (such as r/w access to
our Subversion repository) to support these efforts, by the way. Please
contact me offlist for details.

Bye, Mike

