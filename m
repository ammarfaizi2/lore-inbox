Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWAZOq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWAZOq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWAZOq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:46:27 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:20438 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751353AbWAZOq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:46:26 -0500
Subject: Re: [RFC] VM: I have a dream...
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jamie Lokier <jamie@shareable.org>, Bernd Petrovitsch <bernd@firmix.at>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Diego Calleja <diegocg@gmail.com>, Ram Gupta <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1138252307.3087.110.camel@mindpipe>
References: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl>
	 <1138181033.4800.4.camel@tara.firmix.at>
	 <20060125150516.GB8490@mail.shareable.org>
	 <1138231714.3087.66.camel@mindpipe>
	 <20060126050147.GB23296@mail.shareable.org>
	 <1138252307.3087.110.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 08:46:21 -0600
Message-Id: <1138286781.9946.15.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-26 at 00:11 -0500, Lee Revell wrote:
> What's wrong with Firefox?
> 
> USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> rlrevell  6423  6.7 16.7 167676 73804 ?        Sl   Jan25  79:41 /usr/lib/firefox/firefox-bin -a firefox
> 
> 73MB is not bad.
> 
> Obviously if you open 20 tabs, it will take a lot more memory, as it's
> going to have to cache all the rendered pages.

I had a recent bad experience that I believe was due to a bug in
adblock.  Upgrading to the most recent version of adblock fixed a memory
leak that made firefox unusable after a while.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

