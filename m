Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVCCE1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVCCE1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVCCER7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:17:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18398 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261364AbVCCEQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:16:40 -0500
Message-ID: <42268F93.6060504@pobox.com>
Date: Wed, 02 Mar 2005 23:16:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<42264F6C.8030508@pobox.com>	<20050302162312.06e22e70.akpm@osdl.org>	<42265A6F.8030609@pobox.com>	<20050302165830.0a74b85c.davem@davemloft.net>	<422674A4.9080209@pobox.com>	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>	<42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
In-Reply-To: <20050302200214.3e4f0015.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 02 Mar 2005 22:40:57 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>People don't test 2.6-rc releases because they know they are not 
>>"release candidate, with only bug fixes" releases, which is how the rest 
>>of the world interprets the phrase.
> 
> 
> That's not %100 true.  No matter what -rc* really is, people perceive
> it to be something based upon it's name and whether or not it is an
> official release.  As far as I can see it's %95 perception vs. reality.
> And IT IS part of the reason the -rc's are not as good as they could be.

The reasons -rcs are not as good as they could be is that they include 
more than just bug fixes.  Users are discouraged from testing because 
they must scan LKML, or guess, which -rc that Linus/Andrew started 
getting serious about "bugfixes only."

With the -pre/-rc scheme, it's clear to users.

With the even/odd scheme, you just devalue releases.  Previously, all 
releases were worthy of testing and use.  Now, half of them aren't.

	Jeff


