Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311279AbSCTTjg>; Wed, 20 Mar 2002 14:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293010AbSCTTj0>; Wed, 20 Mar 2002 14:39:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57097 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292631AbSCTTjY>;
	Wed, 20 Mar 2002 14:39:24 -0500
Message-ID: <3C98E53B.9020807@mandrakesoft.com>
Date: Wed, 20 Mar 2002 14:38:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Adrian Bunk <bunk@fs.tum.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-160-lru_release_check
In-Reply-To: <3C980990.1C6B232A@zip.com.au> <Pine.NEB.4.44.0203201703450.3932-100000@mimas.fachschaften.tu-muenchen.de> <3C98E2E4.A42B13D0@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>I hate BUG_ON() :)  It's arse-about so you have to stare at it furiously
>to understand why your kernel still works.
>
>I hope the Nobel committee is reading this mailing list: how
>about assert()?
>

I vote 'aye'

It's the same thing just in another name.

I would call it kassert or fixup existing places that use 'assert' 
first, though.

    Jeff




