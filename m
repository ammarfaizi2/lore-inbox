Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUCSSs0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbUCSSs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:48:26 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:32651
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263079AbUCSSrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:47:45 -0500
Message-ID: <405B403F.4000702@redhat.com>
Date: Fri, 19 Mar 2004 10:47:27 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Woodruff, Robert J" <woody@co.intel.com>
CC: "Woodruff, Robert J" <woody@jf.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
References: <1AC79F16F5C5284499BB9591B33D6F000B4805@orsmsx408.jf.intel.com>
In-Reply-To: <1AC79F16F5C5284499BB9591B33D6F000B4805@orsmsx408.jf.intel.com>
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I should be telling something about another nuance of this problem.


Parties interested in Infiniband have been working under the OpenGroup
umbrella for quite some time now on API extensions to better accommodate
interconnect fibers.  They've even presented at am Austin Group meeting
in 2001 (I think) to get on the road map for being included in POSIX.

But when I wanted to take a look at the specs this was categorically
rejected.  My contacts were explicitly forbidden to give the drafts to
anybody but the elite circle.  Mind you, Red Hat is member of the OpenGroup.

So, these people come up with their own software stacks, unreviewed
interface extensions, and demand that everybody accepts what they were
"designing" without the ability to question anything.

I surely find this completely  unacceptable and any consideration of
accepting anything the Infiniband group comes up with should be
postponed until every bit of the design can be reviewed.  If bits and
pieces are accepted prematurely it'll just be "now that this is support
you have to add this too, otherwise it'll not be useful".

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
