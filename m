Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUFQAYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUFQAYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 20:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUFQAYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 20:24:20 -0400
Received: from motgate7.mot.com ([129.188.136.7]:13966 "EHLO motgate7.mot.com")
	by vger.kernel.org with ESMTP id S264542AbUFQAYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 20:24:18 -0400
In-Reply-To: <16584.20584.603036.208206@cargo.ozlabs.ibm.com>
References: <E6751074-B98D-11D8-B63C-000393DBC2E8@freescale.com> <16584.20584.603036.208206@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A84BD37E-BFF4-11D8-AF45-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
       linux-kernel@vger.kernel.org
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: Support for e500 and 85xx in 2.6
Date: Wed, 16 Jun 2004 19:24:12 -0500
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Now that 2.6.7 is out I've pushed the patch to 
bk://ppc.bkbits.net/for-linus-ppc.  If you can pull it into linux-2.5 
that would be great.

Thanks

- Kumar

On Jun 10, 2004, at 7:13 AM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Once Paul ok's the patches can you please apply them to the 2.6 tree.
>> I've included bk patches because of the addition of several new files.
>> Also, please consider me maintainer of the e500/85xx PPC subarch
>> (unless Paul has any objections), similar to Matt Porter for 4xx PPC.
>
> I'm OK with the patch but I guess it is post-2.6.7 material now.
>
> I'll try to remember to do a patch for MAINTAINERS for Kumar and Matt.
>
> Regards,
> Paul.

