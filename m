Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVJ0LXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVJ0LXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 07:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVJ0LXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 07:23:12 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:37760 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750721AbVJ0LXK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 07:23:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b8iTTYuvOcxNOxEdOVmtVp/ZJopzt3197OLr4KvuJg6aNUjx7RfZk0br51DgZAgPD65k/ykT6XXzuEBeeE5xydELqpDjKjHjZU59EL9rXAlzB0KB6R3+xRjDkhry219kUhrTvX5FcbV9dNOZdJcWYBG4YsaHpNtdbfzADXX9s7U=
Message-ID: <9a8748490510270423x45ffd8c8v773055f5369fe468@mail.gmail.com>
Date: Thu, 27 Oct 2005 13:23:09 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Chaitanya Hazarey <c.v.hazarey@gmail.com>
Subject: Re: Linux Kernel MD5 sums and some question
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a9abfb40510262356o5de2a638pa15d0c8e9dda2833@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a9abfb40510262356o5de2a638pa15d0c8e9dda2833@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Chaitanya Hazarey <c.v.hazarey@gmail.com> wrote:
> Hi all,
>
> Lately I had some problems compiling the kernel source on my machine.
> I guess nothing serious, but one thing came to my notice. I was
> looking for the MD5 sums for the linux kenerl and found none. The Pgp
> signatures are fine , but there seems no way to check the package.
>
Yes, there is a way to check the files; verify the pgp signature. If
the file has been modified the signature won't validate.

> The next question I would like to ask is that, how to I go
> incrementally from linux kernel version 2.6.12.6 to 2.6.13 as no
> patches seem to be provided for it.
>
http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
