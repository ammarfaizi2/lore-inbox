Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946130AbWJSRjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946130AbWJSRjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946133AbWJSRjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:39:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:43761 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946130AbWJSRjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:39:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k5YfZn1pYZC/DCjcKFKkZscorUEHIsZORP8G51UZSyri7EVqTOwbYGC4B0j+hLcduFN3IVdd6B5eiLR2SCRtq4Mz7BzHlUZRTkPgncm3mrrn2pfXitg+YD608oqYTOi/tguk/sbYeYDSNtvM/jdRiWQzN4HoUquASJGOdlbax8w=
Message-ID: <c43b2e150610191039h504b6000u242cadf8d146de9@mail.gmail.com>
Date: Thu, 19 Oct 2006 19:39:10 +0200
From: wixor <wixorpeek@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: VCD not readable under 2.6.18
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1161276178.17335.100.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c43b2e150610161153x28fef90bw4922f808714b93fd@mail.gmail.com>
	 <1161040345.24237.135.camel@localhost.localdomain>
	 <c43b2e150610171116w2d13e47ancbea07c09bd5ffbf@mail.gmail.com>
	 <1161124732.5014.20.camel@localhost.localdomain>
	 <c43b2e150610190935tefd11eev510c7dee36c15a51@mail.gmail.com>
	 <1161276178.17335.100.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> It isn't hidden it should be in the first session
So tell me then, where is it if windows can see it, but linux can't?

> The kernel provides the infrastructure for arbitary CD handling, but
> provides only the file system support in kernel. It can't (and doesn't
> appear to need to) handle VCD in kernel it provides the tools to Xine
> and friends instead.
Well, no doubt it is only m$ who can have vcd player in the kernel -
the point is the CD does NOT get read, neither by xine nor by any
other known to me tool. I asked here because the kernel is the only
source of any messages addressing the unplayability of the CD - all
the others just hang - so it looks like a kernel issue, doesn't it?
And as far as I understand you, you are trying to tell me it is
everything OK with the kernel, and the problem lays somewhere else,
yes?

wixor
