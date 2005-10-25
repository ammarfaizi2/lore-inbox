Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVJYOMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVJYOMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 10:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVJYOMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 10:12:37 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:33618 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932151AbVJYOMg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 10:12:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oWOUqLRckuHzJkVQ/6JZe54ov6atffVQDyghAdl2MYkah24Mjsf7N5QXsFLkhnJPKrvwgGd7n9uPKSCjY/ou16SVXOXwvNTlXGChZcGcc3ZURaTuUqnQCZYBFYlLXCGXU8rohIt/Hkx7CAX4d5geG2X9zeWcynmExqG5QaXw2+c=
Message-ID: <1e62d1370510250712i785f6722ie98ecf4f9f0e13fa@mail.gmail.com>
Date: Tue, 25 Oct 2005 19:12:36 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Block Device <blockdevice@gmail.com>
Subject: Re: Block I/O sizes
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <64c763540510250521yf5e1ac3g221f42ed658d1bf0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64c763540510250243v64c0c22bt4a6e57bb5490fb77@mail.gmail.com>
	 <1e62d1370510250315n690e3455j13f2e1651476d784@mail.gmail.com>
	 <64c763540510250521yf5e1ac3g221f42ed658d1bf0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/05, Block Device <blockdevice@gmail.com> wrote:
>
> >On 10/25/05, Fawad Lateef <fawadlateef@gmail.com> wrote:
>>
> > So, I don't think bi_sector in some case contains block_nr or
> > sector_nr, rather it always keeps sector_nr (CMIIW)
>
> Thanks, I realized I was not checking it correctly. It is always in
> terms of sectors as you
> say.
>
> > And __please__ change your name from Block Device to your real name,
> > its annoying to see Block Device as a name of a person. :(
>
> But really, my real name is block device ... I cant help it ;) !
>

First do reply through reply_to_all, and Second is how your real name
is block device ? Are they really exists and known by your parents at
that time ? :S ;)


--
Fawad Lateef
