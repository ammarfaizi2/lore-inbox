Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbSKOPYN>; Fri, 15 Nov 2002 10:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266353AbSKOPYN>; Fri, 15 Nov 2002 10:24:13 -0500
Received: from bitmover.com ([192.132.92.2]:42651 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266323AbSKOPYM>;
	Fri, 15 Nov 2002 10:24:12 -0500
Date: Fri, 15 Nov 2002 07:31:02 -0800
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <20021115073102.D32321@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"David S. Miller" <davem@redhat.com>, mbligh@aracnet.com,
	linux-kernel@vger.kernel.org
References: <1037325839.13735.4.camel@rth.ninka.net> <396026666.1037298946@[10.10.2.3]> <20021114.231147.22569665.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114.231147.22569665.davem@redhat.com>; from davem@redhat.com on Thu, Nov 14, 2002 at 11:11:47PM -0800
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 11:11:47PM -0800, David S. Miller wrote:
>    From: "Martin J. Bligh" <mbligh@aracnet.com>
>    Date: Thu, 14 Nov 2002 18:35:47 -0800
>    
>    wouldn't you rather know of the breakage sooner rather
>    than later?
>    
> It means I have to track multiple source trees, no thanks.
> I have enough trouble keeping up with what is actually
> in Linus's tree.

This may or may not help but it seems relevant.  BK has uniq names for 
each changeset, we're fixing BK/Web so you can use the uniq names instead
of the revs (which change out from under you).  

So it should be possible to link the bug report with a changeset in Linus'
tree if you want.

It's worth pointing out that if you can see the bug in a particular version
of Linus' tree then *everyone* can see it by getting a copy of the tree
as of that cset.  BK guarentees that if you clone -r<rev> then you'll see
exactly what anyone else saw as of that cset.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
