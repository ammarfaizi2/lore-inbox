Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265067AbUE0TZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbUE0TZN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbUE0TZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:25:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54499 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265067AbUE0TZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:25:06 -0400
Message-ID: <40B64083.9050200@pobox.com>
Date: Thu, 27 May 2004 15:24:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: schizo@debian.org, mcgrof@studorgs.rutgers.edu,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       prism54-devel@prism54.org, debian-kernel@lists.debian.org
Subject: Re: [Prism54-devel] Re: [PATCH 0/14] prism54: bring up to sync with
 prism54.org cvs rep
References: <20040524083003.GA3330@ruslug.rutgers.edu>	<40B63132.4050906@pobox.com>	<20040527182531.GA8942@scowler.net>	<40B63639.6080705@pobox.com> <20040527120544.2fbd4b35.akpm@osdl.org>
In-Reply-To: <20040527120544.2fbd4b35.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> Luis, you, or somebody should create a new patch series with just the 
>> critical fixes, NO WHITESPACE/FORMATTING CHANGES mixed in, and send 
>> those first.
> 
> 
> Whitespace changes are often nice, but they should be the very first
> patch[es] in the series.  You should be able to verify that the .o file was
> unchanged before and after.

Very first, or very last.  I leave that up to the maintainer.


> That way they become a no-brainer and it becomes easier to review and
> understand the substantive changes.

Agreed.

Further, when someone mixes an Lindent in with functional changes, I 
become very suspicious.  That is precisely the method that certain high 
profile Linux hackers have used in the past to intentionally obfuscate 
security changes.

	Jeff


