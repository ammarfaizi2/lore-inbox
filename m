Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWBZRii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWBZRii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWBZRii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:38:38 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:7810 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751357AbWBZRih convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:38:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bM4k1j9f6AVII+3KCw/TLxsnOSETo5IaFXuPRjHTMQux7Q+lMvDEgR/2Mx9oJpzzjujbSsTt6J6ub4ruDlPGvBsB+rkL1kHE5ftwLE3PRtwLgEPLxmgSVXdEiuRqJv8SpGxJHIg7BuS9TEiIwwz4ezHs76Aw1/1EQAkHDThr7YU=
Message-ID: <9a8748490602260938u7213c906w310b943b339344e2@mail.gmail.com>
Date: Sun, 26 Feb 2006 18:38:36 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Cc: "Andrew Morton" <akpm@osdl.org>, "Sam Ravnborg" <sam@ravnborg.org>,
       "Adrian Bunk" <bunk@stusta.de>
In-Reply-To: <200602261721.17373.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
[snip]
>
> That's it for now, I'll get to work trying to clean up some of the breakage
> I've seen, if anyone wants to join in feel free :)
>

Thanks to Adrian Bunk the kernel configuration files and build logs
for all 100 kernels are now online at
ftp://ftp.kernel.org/pub/linux/kernel/people/bunk/jesper/
So those of you who want to take a closer look can go there and grab
whatever you need.

Thanks Adrian.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
