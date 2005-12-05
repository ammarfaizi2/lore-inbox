Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVLERyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVLERyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVLERym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:54:42 -0500
Received: from rtr.ca ([64.26.128.89]:31630 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751344AbVLERym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:54:42 -0500
Message-ID: <43947EE0.3040006@rtr.ca>
Date: Mon, 05 Dec 2005 12:54:40 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Add tainting for proprietary helper modules.
References: <20051203004102.GA2923@redhat.com>	<Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>	<20051205173041.GE12664@redhat.com> <20051205093436.44d146e6@localhost.localdomain>
In-Reply-To: <20051205093436.44d146e6@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> IMHO ndiswrapper can't claim legitimately to be GPL

Sure it is.

The applications it loads and runs may not be GPL,
same as for Linux in general, but ndiswrapper is just fine.

There's no GPL non-conformance unless somebody is distributing
code that extends GPL functionality without GPLing that code.

And NDIS does not violate that.  Sure, it runs binary-only
drivers developed for another O/S, but it is NOT distributing those.

Cheers
