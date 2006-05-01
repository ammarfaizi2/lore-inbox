Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWEARd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWEARd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWEARd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:33:28 -0400
Received: from uproxy.gmail.com ([66.249.92.174]:25057 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932170AbWEARd1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:33:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=egxqqQB94713Ek2okF2xCaSdugXIaRqd0rKFwJWnWhLd6HSh2Tp+HpA+z2OZr2zrQ4DwE/SmNqdL7UqP1drslwokqccIl1UyqG2+mlOHRLZM2wpVqqUbOlmSenrMuya7DBXbKI9hmqBJev0sAnPL7buK0okwyWZyARa369C81Kk=
Message-ID: <625fc13d0605011033h41492f46qb0d31a8d9b26adc@mail.gmail.com>
Date: Mon, 1 May 2006 12:33:26 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc3-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060501095913.13a74b2b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060501014737.54ee0dd5.akpm@osdl.org>
	 <625fc13d0605010554l4cadac0fxe7fbc6cd5d57c679@mail.gmail.com>
	 <20060501095913.13a74b2b.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/06, Andrew Morton <akpm@osdl.org> wrote:
> "Josh Boyer" <jwboyer@gmail.com> wrote:
> >  Hi Andrew,
> >
> >  Any specific reasons the header cleanup trees weren't added?
>
> I'll get onto that later in the month.  I also need to bring in the klibc
> tree.  The two might apparently interact - we'll see..

Ok.  Sounds like it could be fun.. :)

josh
