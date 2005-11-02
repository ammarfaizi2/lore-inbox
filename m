Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965282AbVKBVqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbVKBVqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbVKBVqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:46:08 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:54944 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965276AbVKBVqH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:46:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i0vhq4hzJWuuYCTq2xaVu2kVt1vtrPvtFCQubxtN2OF4cFmO8y6GFiqijrCfOuOnBjYBw1tOMumkOiP6HQEpDOc9e29Z1R5FOnegq1IgCMF5jAP4NSOFEoG8v8hEmd3j0b9IP1uQ+fx6vlGBcRZFgE79q9gt4GCOoeOnvVwIEQs=
Message-ID: <39e6f6c70511021346g43fcba88y77c63fdff8cf9bb6@mail.gmail.com>
Date: Wed, 2 Nov 2005 19:46:06 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Cc: Willy Tarreau <willy@w.ods.org>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, netdev@vger.kernel.org,
       Yan Zheng <yzcorp@gmail.com>
In-Reply-To: <OF9D4BE592.A4BBC034-ON882570AD.00608386-882570AD.006143BA@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051102092959.GA15515@alpha.home.local>
	 <OF9D4BE592.A4BBC034-ON882570AD.00608386-882570AD.006143BA@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/05, David Stevens <dlstevens@us.ibm.com> wrote:
> Willy Tarreau <willy@w.ods.org> wrote on 11/02/2005 01:29:59 AM:
>
> > Marcelo, David, does this backport seem appropriate for 2.4.32 ? I
> verified
> > that it compiles, nothing more.
>
>         Yes.
>
> > If it's OK, I've noticed another patch that
> > Yan posted today and which might be of interest before a very solid
> release.
>
>         I think they should be reviewed first. :-)

Sure thing David, and thanks for your much appreciated review of patches for
the area.

- Arnaldo
