Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVH2WnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVH2WnV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVH2WnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:43:20 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:25750 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751397AbVH2WnU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:43:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mnw8IZxc61lADylqd9qQW1SoFCfQ+ZtnkGU+opc3Pve075+UU7XrGizxtUbmpXJUmZOCLJC3hPN9wyL6px399VwtkcFWo4UeTjhMcqQQExMcmMjLsDvpjposDncnagrVfDrDDWMYBCL2MkwHa0rbXEvhjn4WHzXhyv3tGMF4YbM=
Message-ID: <9a874849050829154311bd433d@mail.gmail.com>
Date: Tue, 30 Aug 2005 00:43:19 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: [PATCH] drivers/net/s2io.h - lvalue fix
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050829222417.GA20292@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050829222417.GA20292@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> Hi all ,
> 
> Sorry if I don't send this patch to the maintainer of s2io, but I don't
> know who is he.
> 
Hmm, neither do I. Looking in MAINTAINERS I don't see anybody, and
looking in the sources I find just a company name `Neterion'.
So, lacking an email address for a maintainer, sending your patch to
linux-kernel is the right thing to do (even if you had found a
maintainer, adding linux-kernel to Cc: would usually also be proper).
If you get no response at all from the list or maintainer, then Andrew
Morton is the head 2.6 maintainer.


> This patch is based on Kernel 2.6.13 release from the Linus tree.
> 
> Is there a process to send patch to the mailing list ?
> 

Check out 
   - Documentation/SubmittingPatches
   - http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
   - http://linux.yyz.us/patch-format.html
   - http://www.tux.org/lkml/#s1-10
   - http://www.tux.org/lkml/#s1-15


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
