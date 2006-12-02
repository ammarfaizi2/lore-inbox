Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424348AbWLBS2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424348AbWLBS2K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424336AbWLBS2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:28:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:51355 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424348AbWLBS2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:28:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BDuzkHzVvu6HOYqjtDVVq23iCz6qj5gNw/C7RkYER8uZ+j+OdOS0QVW5JkWwyhhNb73OsBmR/5VKSz4zAwE/w64LmCQe7fnQJSrS6W2v/L3LaTCr2UE8qUJR22wykiLxX0Pas1XxWjtELA7fqIprCD+8mm0EBpbIvpEZpXhjBV0=
Message-ID: <b1e142760612021028t522ba3ffs485bc70d93a85774@mail.gmail.com>
Date: Sat, 2 Dec 2006 13:28:06 -0500
From: "Ming Zhao" <mingzhao99th@gmail.com>
To: blackmagic02881@gmail.com
Subject: Re: [dm-devel] Re: [RFC][PATCH] dm-cache: block level disk cache target for device mapper
Cc: "device-mapper development" <dm-devel@redhat.com>,
       "bert hubert" <bert.hubert@netherlabs.nl>, ming@acis.ufl.edu,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, ericvh@gmail.com
In-Reply-To: <1165022497.2761.216.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611271826.kARIQYRi032717@hera.kernel.org>
	 <20061127184748.GA11219@outpost.ds9a.nl>
	 <a4e6962a0611271155q55adf6fftd489de84d6ae7e88@mail.gmail.com>
	 <1165022497.2761.216.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Ming Zhang <blackmagic02881@gmail.com> wrote:
> like to see this idea but any similarity with
> http://www.ele.uri.edu/Research/hpcl/STICS/stics.pdf?
>
> STICS is patent pending so not sure if kernel can be free to merge this
> dm-cache.

I like the idea of STICS, an efficient bridge between SCSI and IP. But
I think its only similarity with dm-cache is the use of nonvolatile
caching.

Dm-cache is a generic block-level disk cache that supports a variety
of SAN technologies and is not tied to any particular one.


Best regards,
Ming Zhao
