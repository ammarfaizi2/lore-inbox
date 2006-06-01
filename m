Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWFAVw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWFAVw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWFAVw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:52:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:40559 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750705AbWFAVw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:52:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g01/zuD4mN+eoCT0GWblcgUlKQFJmo01KTHC6Ltviv5Uhe/136aWkj5VbU6TPwgfj7d8NJcuGomsyG2qsmM1k2UaeDisakh78ltr0eHerbfuEsQHIy8C8gKj2PlyzbnPwHb27SmVW64bITyOyqd3LLBneZ5QxBg/fb3X6BZFPt4=
Message-ID: <9a8748490606011452k7c7c8c6erb18feb073e18054d@mail.gmail.com>
Date: Thu, 1 Jun 2006 23:52:55 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <9a8748490606011451m69e2f437uf3822e535f87d9ae@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 01/06/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> >
> >
>
> Got a few build warnings with this one :
>
And some more :

arch/i386/crypto/aes.c:481: warning: initialization from incompatible
pointer type
arch/i386/crypto/aes.c:483: warning: initialization from incompatible
pointer type

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
