Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265014AbUE0SlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265014AbUE0SlU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUE0SlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:41:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34015 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265014AbUE0SlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:41:11 -0400
Message-ID: <40B63639.6080705@pobox.com>
Date: Thu, 27 May 2004 14:40:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clint Adams <schizo@debian.org>
CC: "Luis R. Rodriguez" <mcgrof@ruslug.rutgers.edu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org,
       debian-kernel@lists.debian.org
Subject: Re: [Prism54-devel] Re: [PATCH 0/14] prism54: bring up to sync with
 prism54.org cvs rep
References: <20040524083003.GA3330@ruslug.rutgers.edu> <40B63132.4050906@pobox.com> <20040527182531.GA8942@scowler.net>
In-Reply-To: <20040527182531.GA8942@scowler.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clint Adams wrote:
>>>[PATCH 8/14 linux-2.6.7-rc1] prism54: Fix prism54.org bugs 39, 73
> 
> 
>>I'm considering rejecting the entire series because of this obfuscation 
>>of changes, and getting you to resend with the whitespace crapola 
>>separated out.
> 
> 
> Please at least apply the changes in the "8/14" patch, because without
> them the driver is unusable on big-endian architectures.


The entire patch series was dropped.

Luis, you, or somebody should create a new patch series with just the 
critical fixes, NO WHITESPACE/FORMATTING CHANGES mixed in, and send 
those first.

	Jeff


