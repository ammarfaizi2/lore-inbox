Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWGJNAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWGJNAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWGJNAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:00:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:43291 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161017AbWGJNAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:00:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BtCsQwDzmYljxFryiTvp7N9FWUcbYV3MLp87c2pVwjrlwC0hjAzrixu3Pqk7eb8X5NF0F887UZrRPinXmDBfiPvn9xT2qR2hHN/jp94xHKgaFi8cG5tJVanaBU9QLin3zLmqZYQZgFTuSS3QanXT55udVvD0dZRZ0sRGzfF3FTc=
Message-ID: <9a8748490607100600w125700a0n8a77870998704342@mail.gmail.com>
Date: Mon, 10 Jul 2006 15:00:19 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1152535999.4874.36.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490607100548o14dbe684j40bde90eb19a7558@mail.gmail.com>
	 <1152535999.4874.36.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > So, what do people say?
>
>
> Hi,
>
> I'm just about always in favor of having automated tools help us find
> bugs. However... can you give an indication of how many real bugs you
> have encountered? If it's "mostly noise" all the time.. then it's maybe
> not worth the effort... while if you find real bugs then it's obviously
> worthwhile to go through this.
>
For the parts I've done so far, the only "real" issue is one case of a
superfluous variable. But I'm far from done going through all the
warnings.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
