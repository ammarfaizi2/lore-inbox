Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319322AbSIFSsq>; Fri, 6 Sep 2002 14:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319330AbSIFSsp>; Fri, 6 Sep 2002 14:48:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:8943 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319322AbSIFSsp>;
	Fri, 6 Sep 2002 14:48:45 -0400
Date: Fri, 06 Sep 2002 11:51:29 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>
cc: gh@us.ibm.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
Message-ID: <61930391.1031313088@[10.10.2.3]>
In-Reply-To: <20020906.113611.102227888.davem@redhat.com>
References: <20020906.113611.102227888.davem@redhat.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    The fact that we're doing something different from everyone else
>    and turning up a different set of kernel issues is a good thing, 
>    to my mind. You're right, we could use Tux if we wanted to ... but
>    that doesn't stop Apache being interesting ;-)
> 
> Tux does not obviate Apache from the equation.
> See my other emails.

That's not the point ... we're getting sidetracked here. The
point is: "is this a realistic-ish stick to beat the kernel
with and expect it to behave" ... I feel the answer is yes.

The secondary point is "what are customers doing in the field?"
(not what *should* they be doing ;-)). Moreover, I think the
Apache + Tux combination has been fairly well beaten on already
by other people in the past, though I'm sure it could be done
again.

I see no reason why turning on NAPI should make the Apache setup
we have perform worse ... quite the opposite. Yes, we could use
Tux, yes we'd get better results. But that's not the point ;-)

M.

