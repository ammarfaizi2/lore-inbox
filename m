Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756884AbWKUXzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbWKUXzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbWKUXzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:55:19 -0500
Received: from nz-out-0102.google.com ([64.233.162.205]:4472 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1756884AbWKUXzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:55:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W54OdHj6Rxmd9ki4xbtFXWznuMm90QlzMU94guvKX8zSQzIxly142ZdqFHiB8AJi0XZVjTtf29bvnwJA6jz/xE0QlglMOCsKWWvFJHzJZ9ErKwjz19LG254f0b+9O8Qm57aeyTwmqv7f3C9haWTm7dsiGoGL5hLx8ANb88Y0wOA=
Message-ID: <9a8748490611211555r8c51870q2f34892a806e9303@mail.gmail.com>
Date: Wed, 22 Nov 2006 00:55:16 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Maarten Maathuis" <madman2003@gmail.com>
Subject: Re: A curious user would like to know what anonpages are.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6d4bc9fc0611211530te8b9b6m84860c7aacdd1b01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d4bc9fc0611211530te8b9b6m84860c7aacdd1b01@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/06, Maarten Maathuis <madman2003@gmail.com> wrote:
> Recently i noticed an (in my eyes) unexplainable memory loss, I
> couldn't trace it a specific process, the slab, buffers or any of the
> usual places.
>
> cat /proc/meminfo revealed something called anonpages, which seemed to
> be around a 100 MiB large.
>
> I have no idea what they are, searching the mailinglist archives or
> using a conventional search engine didn't yield anything usefull.
>
> Can anyone enlighten a curious user?
>

Hmm, wouldn't that be "anonymous pages"?  See http://lwn.net/Articles/77106/


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
