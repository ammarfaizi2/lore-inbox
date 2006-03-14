Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWCNOaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWCNOaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWCNOaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:30:18 -0500
Received: from mxsf03.cluster1.charter.net ([209.225.28.203]:59587 "EHLO
	mxsf03.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750821AbWCNOaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:30:17 -0500
X-IronPort-AV: i="4.02,190,1139202000"; 
   d="scan'208"; a="78550110:sNHT32026172"
Message-ID: <4416D360.6020708@cybsft.com>
Date: Tue, 14 Mar 2006 08:29:52 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>
Subject: Re: 2.6.16-rc6-rt3
References: <20060314084658.GA28947@elte.hu>  <4416C6DD.80209@cybsft.com> <1142345604.4237.5.camel@localhost.localdomain>
In-Reply-To: <1142345604.4237.5.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
<snip>
> Hmm, you didn't do a make modules_install, then change some of the
> config options, do a make install and forget to do a modules_install did
> you?  That error looks like the error I get when I do something like
> that.

Not likely, but...

> 
> If you have done more than one make and install, could you do a make
> clean and start again?  Just to make sure it's not a incompatibility
> between makes.
> 
> Thanks,
> 
> -- Steve

I am trying a clean build because I too have had similar problems in the
past and I have been using this tree for a while.

-- 
   kr
