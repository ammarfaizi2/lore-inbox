Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVFRKm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVFRKm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 06:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVFRKm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 06:42:59 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:63787 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262062AbVFRKm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 06:42:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LD76achMeNlKynQaAqeg1LtC0o2BYeUPJ4JVuOl1gSqkPFxBAKqx0aSTn2M8TKTiWiIUMXtn3miiOknabVFyi7UWCyrkwASBysv1/xqi44zUhpBg4/kHlDVo+HRZJ1dIJUhayPz6vN8HR49f9RAdZLWa6QmMcUy1ZPoOs01oz+o=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: Linux 2.6.12
Date: Sat, 18 Jun 2005 14:48:32 +0400
User-Agent: KMail/1.7.2
Cc: Willy Tarreau <willy@w.ods.org>, Linus Torvalds <torvalds@osdl.org>,
       Keith Owens <kaos@ocs.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <21446.1119073126@ocs3.ocs.com.au> <20050618065911.GH8907@alpha.home.local> <Pine.LNX.4.62.0506181231410.2653@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0506181231410.2653@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181448.34181.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2005 14:36, Jesper Juhl wrote:
> --- linux-2.6.12-orig/Documentation/dontdiff
> +++ linux-2.6.12/Documentation/dontdiff
> @@ -138,3 +138,4 @@
>  wanxlfw.inc
>  uImage
>  zImage
> +pax_global_header

In alphabetic order, please.
