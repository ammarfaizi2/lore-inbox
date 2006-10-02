Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWJBOJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWJBOJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 10:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWJBOJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 10:09:51 -0400
Received: from smtp-out.google.com ([216.239.45.12]:49147 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932372AbWJBOJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 10:09:50 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=ovEDWete82DjAxBbdGcA0eCE+SvcHtpFGGezGnE08L6hxHsaKBXeQcTWj5w0+gcaI
	1CLgjB0BctAi5tPFljtFQ==
Message-ID: <d43160c70610020709l720518a8j1aea5e04e9cdd20c@mail.gmail.com>
Date: Mon, 2 Oct 2006 10:09:36 -0400
From: "Ross Biro" <rossb@google.com>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [patch 024/144] allow /proc/config.gz to be built as a module
Cc: "Andrew Morton" <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@google.com, sam@ravnborg.org
In-Reply-To: <20061001115241.fb9dc96d.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610010627.k916RPIs010370@shell0.pdx.osdl.net>
	 <20061001093954.8d2aa064.rdunlap@xenotime.net>
	 <20061001113600.3c318eda.akpm@osdl.org>
	 <20061001115241.fb9dc96d.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> > Actually I had this mentally tagged as "needs more arguing before merging"
> > but then forgot and went and sent it anyway.
>
> Well, we agree on that part at least.
>
> > So now it's in the "needs more arguing before we revert it" category.
>
> Wrong order IMO.

I think we should pull it and then argue about putting it back in.

    Ross
