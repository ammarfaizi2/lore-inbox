Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVJKHNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVJKHNn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 03:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVJKHNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 03:13:43 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:55445 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751399AbVJKHNm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 03:13:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dS/+P2MuzUHQicfO+PzeuMs0aI5hKY5S1SrTlg3owc619LtmL1JdGsnUratygFN+0ZvnPgrZD5dMHDrQ5jnQwXa6njzvk4dHqqZKniK4zfbPf8nQfROfEy9pThfzNoCLuaLoG4Q1WSzQFlw59KyTMGVqiQ5j1YUPVGMD8iE2mvs=
Message-ID: <21d7e9970510110013q830adf4n5e9a27b4ff25d510@mail.gmail.com>
Date: Tue, 11 Oct 2005 17:13:41 +1000
From: Dave Airlie <airlied@gmail.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Subject: Re: Direct Rendering drivers for ATI X300 ?
Cc: Lars Roland <lroland@gmail.com>, Gerhard Mack <gmack@innerfire.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1129010221.6277.6.camel@bip.parateam.prv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0510101230360.8804@innerfire.net>
	 <4ad99e050510101200m6f3e1abh7ff8fb6b08b3c0e6@mail.gmail.com>
	 <21d7e9970510101726h5bf920f0y3b7c42a6ff98734e@mail.gmail.com>
	 <1129010221.6277.6.camel@bip.parateam.prv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Le mardi 11 o
> > For PCI Express Radeon cards:
> >
> > The kernel portions are in my -git tree ready for pushing to Linus
> > after the next release is made,
>
> Is the kernel support for AGP R300 already in the kernel, or is it
> scheduled to go later ?
>

Should be there since 2.6.13....

Dave.
