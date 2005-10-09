Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVJIIU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVJIIU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 04:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVJIIU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 04:20:59 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:12558 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932240AbVJIIU6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 04:20:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AbWxdg1geCPZCphrINt9B+Y6mCK5j7++Q/vzeXXXCuUxpdrrTJq1/ZrN14bIjzYpCFgKFt+zM61K207pA72jQaLIsq/sev7UNSTR90LXydFXUTlRassHRahMHdVtA0JEgwScxeNGejYiQzHArljws068J2SHRRBmTpd4i19ZHlM=
Message-ID: <2cd57c900510090120i27de6d0g110a3ee104f7e4a3@mail.gmail.com>
Date: Sun, 9 Oct 2005 16:20:57 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: [Security] "stable" vs "security stable"
Cc: webmaster@kernel.org, security@kernel.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051009080937.GS5856@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cd57c900510082307q1841ce8dob1dce3b24edf4ad0@mail.gmail.com>
	 <20051009080937.GS5856@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/05, Chris Wright <chrisw@osdl.org> wrote:
> * Coywolf Qi Hunt (coywolf@gmail.com) wrote:
> > I find the kernel.org first page inconvenient for some people somehow
> > since the security stable came.
>
> It's stable, not security stable.  It does contain security fixes
> sometimes, but it is generally about patches that improve kernel
> stability.

OK, "stable" vs "base" now. 2.6.13.3 is the latest stable, and 2.6.13
is the latest base.

>
> > Now on the kernel.org page, we have 2.6.13.3 and 2.6.14-rc3. If one
> > wants to get 2.6.14-rc3, he shouldn't get 2.6.14-rc3 Full, but
> > 2.6.14-rc3 Patch and 2.6.13 Full, which isn't there unfortunately. I
> > suggest we name 2.6.13.3 "security stable", and 2.6.13 "stable".
>
> Perhaps a column B for base.  Or just link to ketchup and be done with it.
>

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
