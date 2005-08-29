Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVH2PI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVH2PI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 11:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVH2PI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 11:08:27 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:7694 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751203AbVH2PI0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 11:08:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WGydD0yvrclwcb4mOiwQV/UNpCWmGxIYQIbu7JXHnGzeJDiRKOreIzaBV3J3PoG8mKCrLnaMhjh7QD4j/D/J/LuUty6t6UAw6Vl4EPsxxuxGgEkL4+LlhWe7AZustClWC9V6eix6giusc2GrOhSKFAryDZJ4En8VrAf1zxanKxk=
Message-ID: <9a874849050829080823cf452f@mail.gmail.com>
Date: Mon, 29 Aug 2005 17:08:25 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Pete Popov <ppopov@mvista.com>
Subject: Re: [PATCH 2/3] exterminate strtok - drivers/video/au1100fb.c
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1125327974.6104.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508242108.32885.jesper.juhl@gmail.com>
	 <1124950581.14435.978.camel@localhost.localdomain>
	 <9a8748490508290443ab7cd62@mail.gmail.com>
	 <1125326968.6104.4.camel@localhost.localdomain>
	 <9a8748490508290800bba68c1@mail.gmail.com>
	 <1125327974.6104.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/05, Pete Popov <ppopov@mvista.com> wrote:
> > Then I must be blind, because I still see the old strtok() using code
> > in there :
> 
> You must be looking at kernel.org. I'm talking about linux-mips.  Any

Yes, I was looking at 2.6.13 from kernel.org. 

> linux mips patches should go through linux-mips.org and Ralf eventually
> gets them into kernel.org.
> 
Ohh, ok.  No problem then :)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
