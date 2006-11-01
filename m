Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945988AbWKABka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945988AbWKABka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946266AbWKABk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:40:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:30052 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1945988AbWKABk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:40:28 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,377,1157353200"; 
   d="scan'208"; a="153912846:sNHT161016716"
Message-ID: <4547FB21.3050509@linux.intel.com>
Date: Tue, 31 Oct 2006 17:40:49 -0800
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.7) Gecko/20061019 SeaMonkey/1.0.5
MIME-Version: 1.0
To: dragoran <dragoran@feuerpokemon.de>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: ipw3945?
References: <45464A2C.5090402@feuerpokemon.de>
In-Reply-To: <45464A2C.5090402@feuerpokemon.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dragoran wrote:
...
> It seems that the development of the driver has stopped since july,
> maybe because it never will get merged and intel decided to stop working
> on it?

Development hasn't stopped, I'm just a slacker ;).  I was away from work
for a while, and on return I was sucked into various issues that have
now (hopefully) all been resolved (or routed to /dev/null).

We have several patches that have backed up in our bug database
(http://bughost.org/cover/ and click on 'tested patches') that I'll be
pushing to our GIT tree as well as releasing a new snapshot to SF.

We've also been working on some new code internally we're putting
through some testing before we push out.  Expect some good things in the
coming weeks.

> If this is true it could mean that feature intel wlan chips will end up
> with no linux drivers :(

We do what we can internally to ensure that is never the case.

James
