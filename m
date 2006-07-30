Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWG3TZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWG3TZD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWG3TZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:25:01 -0400
Received: from [72.14.214.204] ([72.14.214.204]:42951 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932454AbWG3TZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:25:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=knkDksXgCyOk/IJNJ2VWCirP5wMSnNvyRJKe/a5WFp4JJdeu2t5LZzAuCjvXbKvxvyzyRNAoKKTAmelnTYOmKLebHtjPiEUXBHxsVbwNKqJYCI3XlE9In3Y5PogCrgI03N22bya7Ed7YbgK483c1J6nHkVky5L2qga/ZPbNsNXA=
Message-ID: <9a8748490607301224y63e7e9ah895722efe4c6e371@mail.gmail.com>
Date: Sun, 30 Jul 2006 21:24:59 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial step
Cc: "Andrew Morton" <akpm@osdl.org>, "Nikita Danilov" <nikita@clusterfs.com>,
       "Joe Perches" <joe@perches.com>, "Martin Waitz" <tali@admingilde.org>,
       "Jan-Benedict Glaw" <jbglaw@lug-owl.de>,
       "Christoph Hellwig" <hch@infradead.org>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Valdis Kletnieks" <Valdis.Kletnieks@vt.edu>,
       "Sam Ravnborg" <sam@ravnborg.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Rusty Russell" <rusty@rustcorp.com.au>,
       "Randy Dunlap" <rdunlap@xenotime.net>,
       "Jesper Juhl" <jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607301830.01659.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Ok, here we go again...
>
> This is a series of patches that try to be an initial step towards making
> the kernel build -Wshadow clean.
>
Replying to myself here since I forgot one little bit.

It would be great if maintainers of the various areas that my patches
touch would explicitly ack or nack patches - preferably giving reasons
for nack's as well.
That would help me a lot in updating the patch-set (if so needed).

Thanks.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
