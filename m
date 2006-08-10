Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161186AbWHJS4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbWHJS4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWHJS4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:56:45 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:49057 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161186AbWHJS4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:56:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b7s2WkGQ19RM/E8i1LRi6T/yCKDyeCmE+KN9X4sw7OWU0csfTq80irTEu+gSv+KLB2ki8mI+n4vogb9REYHYyZwev2/fKD+VAuGaAqSuQxAIIw37MsmIclg4I9hq3ucZZBkYcBLWo/sRfNqmbzRGBaMgblf5W871Wfc+NMG5hOI=
Message-ID: <1defaf580608101156r63e07abakc2a51dba4fdd1581@mail.gmail.com>
Date: Thu, 10 Aug 2006 20:56:42 +0200
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 0/14] Generic ioremap_page_range: introduction
Cc: "Haavard Skinnemoen" <hskinnemoen@atmel.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, "Andi Kleen" <ak@suse.de>,
       "Richard Henderson" <rth@twiddle.net>,
       "Mikael Starvik" <starvik@axis.com>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Paul Mundt" <lethal@linux-sh.org>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Kyle McMartin" <kyle@parisc-linux.org>,
       "Ralf Baechle" <ralf@linux-mips.org>
In-Reply-To: <20060810115138.854c94ad.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155225826761-git-send-email-hskinnemoen@atmel.com>
	 <1defaf580608101142u7f5122b5le06a968b793d552d@mail.gmail.com>
	 <20060810115138.854c94ad.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 10 Aug 2006 20:42:19 +0200
> "H__vard Skinnemoen" <hskinnemoen@gmail.com> wrote:

(wonder why gmail keeps resetting my name all the time...this is the
third time I'm changing it to "Haavard Skinnemoen")

> > I'll submit a patch to the git mailing list tomorrow, and then I'll
> > resend the bad patches manually.
>
> Is OK, I'll fix them up.  I assume they're all really From:yourself?

Thanks. They're all from me, yes.

Haavard
