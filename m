Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965309AbVKIITa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbVKIITa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbVKIITa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:19:30 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:59333
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965309AbVKIIT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:19:29 -0500
Message-Id: <4371BF59.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 09:20:25 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: make trap information available to die
	handlers
References: <4370AEE1.76F0.0078.0@novell.com>   <4370E5C4.76F0.0078.0@novell.com> <Pine.LNX.4.58.0511080853360.15288@shark.he.net>  <4370E9A2.76F0.0078.0@novell.com> <Pine.LNX.4.58.0511080912090.15288@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0511080912090.15288@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> "Randy.Dunlap" <rdunlap@xenotime.net> 08.11.05 18:13:28 >>>
>On Tue, 8 Nov 2005, Jan Beulich wrote:
>
>> >And the patch (attachment) also contains From:, but it's missing
>> >a Signed-off-by: line.
>>
>> I looked at many ChangeLog entries (which supposedly get created
from
>> the abstract), and by far not all of them have the author listed
both as
>> From: and Singed-Off-By:, which made me think that either of the
two
>> should be sufficient (and I really can't see why the author
information
>> needs to appear twice).
>
>Tools can determined the From: part from your email, so it's
>often safe to omit that part.
>
>The S-o-b part is required...

Strange. Andi Kleen specifically asked me to add From: to my patches...
And I still can't see why the author of a patch wouldn't implicitly sign
off on it.

Jan
