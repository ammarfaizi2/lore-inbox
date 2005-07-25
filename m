Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVGYXzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVGYXzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 19:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGYXzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 19:55:39 -0400
Received: from opersys.com ([64.40.108.71]:60432 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261470AbVGYXzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 19:55:37 -0400
Message-ID: <42E57A21.6020002@opersys.com>
Date: Mon, 25 Jul 2005 19:47:45 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Paul Jackson <pj@sgi.com>, bert hubert <bert.hubert@netherlabs.nl>,
       rostedt@goodmis.org, relayfs-devel@lists.sourceforge.net,
       richardj_moore@uk.ibm.com, varap@us.ibm.com,
       linux-kernel@vger.kernel.org, zanussi@us.ibm.com
Subject: Re: [PATCH] Re: relayfs documentation sucks?
References: <17107.6290.734560.231978@tut.ibm.com> <20050716210759.GA1850@outpost.ds9a.nl> <17113.38067.551471.862551@tut.ibm.com> <20050717090137.GB5161@outpost.ds9a.nl> <17114.31916.451621.501383@tut.ibm.com> <20050717194558.GC27353@outpost.ds9a.nl> <1121693274.12862.15.camel@localhost.localdomain> <20050720142732.761354de.pj@sgi.com> <20050720214519.GA13155@outpost.ds9a.nl> <20050722130132.60f1524e.pj@sgi.com> <20050723185303.GB7934@infradead.org>
In-Reply-To: <20050723185303.GB7934@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig wrote:
> That beein said I wish LTT folks would make a little more progress so
> we could actually include it.

We're working on it. On the topic of revamping LTT, 3 different people
came up with 3 different implementations.

Following your feedback on the patch I sent a few weeks back, I headed
out asking myself "what is the bare-minimum tracing functionality that
will actually fly while still being flexible enough to add to it?" I
spent some time at the OLS comparing notes with others interested in this
area, and I think we've got something that should fit the bill. We should
be able to post something sooner rather than later.

Now if only I could remember what I talked about after I left the Black
Thorn at 2h45am and the guy in the elevator at Les Suites pressed on a
button and said "'M' for more beer" ...

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
