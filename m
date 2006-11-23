Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933685AbWKWNZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933685AbWKWNZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 08:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933696AbWKWNZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 08:25:35 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:3633 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933685AbWKWNZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 08:25:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tXA/49Ezy8anoe5F72Pq9IVpD0Ft8bCtnFA6cY3xx0nOO+E9cP6cstpZP1Hk53tAgF9p4Fkf9cTVgV1bbZwmQE3KwMdWMH2rAA5pnI0Y7LjO6OLXEs+hmtiOBw8mvSd8ozLFt1DS01nvQBWZKz4sOipndy/VJ55yIS33DeSzM7M=
Message-ID: <9a8748490611230525v6516e070nf7fa990d46c6a87@mail.gmail.com>
Date: Thu, 23 Nov 2006 14:25:33 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: BUG: 2.6.19-rc6 net/irda/irlmp.c
Cc: "Ian Molton" <spyro@f2s.com>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <1164287745.5968.206.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45657BD4.5040604@f2s.com>
	 <9a8748490611230513y258ab33cgf9733b2a8cd93f74@mail.gmail.com>
	 <1164287745.5968.206.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Thu, 2006-11-23 at 14:13 +0100, Jesper Juhl wrote:
>
> > Linus: I think that commit should either be reverted or fixed in a
> > different way before 2.6.19.
>
> Andrew already said he'd push the required patches to Linus:
>
>   http://lkml.org/lkml/2006/11/22/283
>
Ahh, OK, I had missed that. Thank you for pointing that out.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
