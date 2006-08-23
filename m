Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWHWEgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWHWEgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 00:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWHWEgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 00:36:16 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:35213 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751367AbWHWEgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 00:36:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tkD41sJDB8mF2yxOZ4E8pcRUdRKlyf63TEcZ9i5atqel58grnyX2eKD1doeMG4oCm287SpmuEirBjg7xrgrri4iLVUrTY+F8j9QLnZJA5JsFcZXgKZ4dWqfUDPAobNP9WyqT4YzgZvPJILtc36qSS6OUr01sxwvb+g/BFL3afOY=
Message-ID: <36e6b2150608222136y37f821e2g90ea5591a16c54b5@mail.gmail.com>
Date: Wed, 23 Aug 2006 08:36:15 +0400
From: "Paul Drynoff" <pauldrynoff@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [BUG] Can not boot linux-2.6.18-rc4-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060822123850.bdb09717.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060822125118.12ba1ed4.pauldrynoff@gmail.com>
	 <20060822123850.bdb09717.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/06, Andrew Morton <akpm@osdl.org> wrote:
> I tried to reproduce this with qemu but wasn't able to work out in less
> than sixty seconds (== one attention-span) how to find and use a suitable
> userspace image.  Help.  Could you please suggest where such an image can
> be obtained and how it should be invoked to reproduce this?
>

If you still need answer to this question,
there is "zoo" of OSes here:
http://www.oszoo.org/wiki/index.php/Main_Page

I suppose using this image you can reproduce problem:

http://www.oszoo.org/wiki/index.php/Category:Gentoo_images
