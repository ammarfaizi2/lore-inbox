Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030650AbWHJSmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030650AbWHJSmW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030655AbWHJSmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:42:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:11145 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030650AbWHJSmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:42:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fGcYHe06q8BuxY167daojiLrskCtU9kpIu8kcTpNLpjE4JU6XI54uX3auSIlbi/VmmK9H3Zwl+ou+3m6FaVXbgiIxexcJxEYGbyh57XEieJ4RntBrQk2ubMZYDLXlDQVWYjLK6C3Dx2N6slknR5D2qQRxg8ImrIsepRuVzauGis=
Message-ID: <1defaf580608101142u7f5122b5le06a968b793d552d@mail.gmail.com>
Date: Thu, 10 Aug 2006 20:42:19 +0200
From: "=?ISO-8859-1?Q?H=E5vard_Skinnemoen?=" <hskinnemoen@gmail.com>
To: "Haavard Skinnemoen" <hskinnemoen@atmel.com>
Subject: Re: [PATCH 0/14] Generic ioremap_page_range: introduction
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, "Andi Kleen" <ak@suse.de>,
       "Richard Henderson" <rth@twiddle.net>,
       "Mikael Starvik" <starvik@axis.com>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Paul Mundt" <lethal@linux-sh.org>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Kyle McMartin" <kyle@parisc-linux.org>,
       "Ralf Baechle" <ralf@linux-mips.org>
In-Reply-To: <1155225826761-git-send-email-hskinnemoen@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155225826761-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> Hopefully at least -- I'm not 100% confident with
> git-send-email yet, but I'm getting there :)

Apparently, I still have a long way to go. It looks like
git-send-email inserts a bogus "From:" line in patches with a Cc: line
in the mbox header.

I'll submit a patch to the git mailing list tomorrow, and then I'll
resend the bad patches manually. I'm terribly sorry for the noise.

Haavard
