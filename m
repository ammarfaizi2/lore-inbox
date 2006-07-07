Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWGGREN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWGGREN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWGGREM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:04:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:56223 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932178AbWGGREM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:04:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TpfKhtgPXMWP+KlWaPZu6I1AYUThhE4BxmF45qvx1k6Q8VB7ohAvJdj1B0fm9e1PVjKifEybh12PVJdU40iaPTdP9KTxZkoIvAaPIYR5RoqgTVnvEDuWlDO09EoqJFgI6Go51JNH9VTEM5s8Wj1Bb+hnYiuvzG0jxp9O3zoE4Zk=
Message-ID: <dda83e780607071004o75a9c764yd0e42802477e1b91@mail.gmail.com>
Date: Fri, 7 Jul 2006 10:04:10 -0700
From: "Bret Towe" <magnade@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Bret Towe" <magnade@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 bttv modprobe null pointer dereference
In-Reply-To: <20060707064610.GA27347@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <dda83e780607062051x220841c7ya88ff0aefd5d3071@mail.gmail.com>
	 <20060706215225.290360bf.akpm@osdl.org>
	 <dda83e780607062219q1db55c58ga7eb1d5438635dcc@mail.gmail.com>
	 <20060707064610.GA27347@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/06, Dave Jones <davej@redhat.com> wrote:
> On Thu, Jul 06, 2006 at 10:19:09PM -0700, Bret Towe wrote:
>  > ill be recompiling without it and seeing if anything looks odd
>  > and the mce i think has always been there as i recall seeing it
>  > when i did previous bug reports
>
> If you're getting recurring machine checks, that smells strongly
> like a hardware problem.  Have you tried running memtest on
> this box ?

not for some time if the memory is bad its must not be very much
cause im not seeing any random effects id expect of memory failure
i will however run a test tho and see what turns up

>
>                 Dave
>
> --
> http://www.codemonkey.org.uk
>
