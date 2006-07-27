Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWG0Ntb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWG0Ntb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbWG0Ntb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:49:31 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:12995
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S1161076AbWG0Nta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:49:30 -0400
Date: Thu, 27 Jul 2006 15:50:55 +0200
From: andrea@cpushare.com
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Luigi Genoni <genoni@sns.it>, Adrian Bunk <bunk@stusta.de>,
       andrea@cpushare.com, "J. Bruce Fields" <bfields@fieldses.org>,
       Hans Reiser <reiser@namesys.com>, Nikita Danilov <nikita@clusterfs.com>,
       Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: the ' 'official' point of view' expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060727135055.GA6877@opteron.random>
References: <2870.192.167.206.189.1153998447.squirrel@darkstar.linuxpratico.net> <200607271330.k6RDUaPC008087@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607271330.k6RDUaPC008087@laptop13.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 09:30:36AM -0400, Horst H. von Brand wrote:
> Nope. Some people run kernels that include reiser4. That is all you can
> infer, and that I knew beforehand. They are at least 35, and that I'd have

Well, if they were sure they could never get any benefit by reiser4
they wouldn't be testing it in the first place...

But certainly the fact they're testing it, doesn't mean they're
actually going to use it forever. You can monitor the 35 users live
with this link and to see if they increase or decrease over time ;)

	http://klive.cpushare.com/?order_by=kernel_group&where_machine=all&branch=all&scheduler=all&smp=all&live=live&ip=all

They're ordered by cumulative uptime and not by the number of
users. For example there are only 10 jfs users but those 10 jfs users
have a much larger average uptime (59 days) so they score much higher
in the cumulative uptime too. Why the average reiser4 uptime is much
lower is unknown, it could be because they shutdown the system by
night, or because they upgrade kernel so frequently, or because the
system crashes.
