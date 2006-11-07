Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753447AbWKGW5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbWKGW5V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbWKGW5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:57:21 -0500
Received: from smtp-out.google.com ([216.239.33.17]:39634 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1753447AbWKGW5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:57:20 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=bYNVO5GOASdYSSeI02H4hgjwtdF++F37HFmxSQ406OqD4GXY5YyUW8zsiZ2TVSSSA
	mNjtDclRgGFdryx3ZoPNQ==
Message-ID: <8f95bb250611071457g689e7b48v90d381f82cfed22e@mail.gmail.com>
Date: Tue, 7 Nov 2006 14:57:10 -0800
From: "Aaron Durbin" <adurbin@google.com>
To: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH] i386: Update MMCONFIG resource insertion to check against e820 map.
Cc: "Matthew Wilcox" <matthew@wil.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <b6a2187b0611071444y744c240fq13f4e0cb9cdb2da3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8f95bb250611071408x46d6fd1ejb6ef7c59a00f1cb@mail.gmail.com>
	 <b6a2187b0611071444y744c240fq13f4e0cb9cdb2da3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> On 11/8/06, Aaron Durbin <adurbin@google.com> wrote:
> >
> > Signed-off-by: Aaron Durbin <adurbin@google.com>
> >
> > This patch is against 2.6.19-rc4. It is only compile tested for i386,
> > but it is the same patch as x86-64 that I previously submitted.
>
> Tested on 2 different machines and MMCONFIG now works!
>
> Thanks,
> Jeff.
>

Jeff,

Do you mind posting your dmesg from the machine that originally didn't work? I
would like to take a look it.

Thanks.

-Aaron
