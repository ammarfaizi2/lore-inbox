Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751795AbWJWIGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbWJWIGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWJWIF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:05:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:62564 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751795AbWJWIF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:05:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lqS+tqJLHg2QOjIVg/KCOtazahFDsMH0NFZs3m+SzkHqi2sHdRF/cgc79uR/yq3jW4nYPvHdK0/fvzh2z4+fyhEvkmbQnCc3uKe4TNEfHzZjqYvZzukGaD1slpjauwPXFZ9A43SGwJJzHqCka1hgdMEt0p0DFGQYOCxW8v+XUmw=
Message-ID: <86802c440610230105m21409f64t457c0b91511bee1b@mail.gmail.com>
Date: Mon, 23 Oct 2006 01:05:57 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: "Muli Ben-Yehuda" <muli@il.ibm.com>
Subject: Re: [PATCH] x86-64: using cpu_online_map instead of APIC_ALL_CPUS
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, "Andi Kleen" <ak@muc.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20061023074335.GM4354@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <86802c440610220942m4fc77edbi7b6d62a2b2b378c5@mail.gmail.com>
	 <m1k62sz150.fsf@ebiederm.dsl.xmission.com>
	 <86802c440610221258q29b19839i7290b628424f7dba@mail.gmail.com>
	 <20061023074335.GM4354@rhun.haifa.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please test two patchs from eric.

YH

On 10/23/06, Muli Ben-Yehuda <muli@il.ibm.com> wrote:
> On Sun, Oct 22, 2006 at 12:58:57PM -0700, Yinghai Lu wrote:
>
> > Muli,
> >
> > Can you test this one?
>
> I assume it was superceded by a later patch, please let me know if it
> wasn't.
>
> Cheers,
> Muli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
