Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUGBBYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUGBBYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 21:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUGBBYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 21:24:53 -0400
Received: from opersys.com ([64.40.108.71]:64517 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265515AbUGBBYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 21:24:48 -0400
Message-ID: <40E4B20F.8010503@opersys.com>
Date: Thu, 01 Jul 2004 20:53:35 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Peter Martuccelli <peterm@redhat.com>, faith@redhat.com, davidm@hpl.hp.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       ray.lanza@hp.com, Thomas Zanussi <trz@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH] IA64 audit support
References: <200406301556.i5UFuGg8009251@redrum.boston.redhat.com> <20040701124644.5e301ca0.akpm@osdl.org>
In-Reply-To: <20040701124644.5e301ca0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's what I was trying to say:

Andrew Morton wrote:
> It's nice and simple.

I, and quite a few other folks, have been trying to get the Linux Trace Toolkit
in the kernel for the past 5 years and the code being added is almost identical
to what the audit patch adds, yet we've always got reponses such "this is
bloated" and Linus told us that he didn't see the use of this kind of stuff.

Have we simply not figured out the secret handshake?

I'd really like to have some advice here since I believe we have tried every
trick in the book: posting the patches for review, asking kernel developers for
input, porting the patches to multiple architectures, modulirizing the system,
etc.

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

