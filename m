Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264427AbTCXVU3>; Mon, 24 Mar 2003 16:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264428AbTCXVU3>; Mon, 24 Mar 2003 16:20:29 -0500
Received: from packet.digeo.com ([12.110.80.53]:44187 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264427AbTCXVU2>;
	Mon, 24 Mar 2003 16:20:28 -0500
Date: Mon, 24 Mar 2003 15:36:02 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: lm@bitmover.com, venkatesh.pallipadi@intel.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: lmbench results for 2.4 and 2.5 -- updated results
Message-Id: <20030324153602.28b44e23.akpm@digeo.com>
In-Reply-To: <543480000.1048540161@flay>
References: <C8C38546F90ABF408A5961FC01FDBF19010485F1@fmsmsx405.fm.intel.com>
	<20030324200105.GA5522@work.bitmover.com>
	<543480000.1048540161@flay>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 21:31:18.0857 (UTC) FILETIME=[B50A1B90:01C2F24C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> On a slightly related note, I played with lmbench a bit over the weekend,
> but the results were too unstable to be useful ... they're also too short
> to profile ;-( 
> 
> I presume it does 100 iterations of a test (like fork latency?). Or does 
> it just do one? Can I make it do 1,000,000 iterations or something
> fairly easily ? ;-) I didn't really look closely, just apt-get install
> lmbench ... 

Yes, that is something I've wanted several times.  Just a way to say "run
this test for ever so I can profile the thing".

Even a sleazy environment string would suffice.

