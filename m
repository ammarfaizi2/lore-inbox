Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWEGTmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWEGTmz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 15:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWEGTmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 15:42:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:30348 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932218AbWEGTmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 15:42:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=amEWRfVuccy8hr474kXz2tH7FIx/ZWOvA0Z2YO8a3rL5wHji9eFNyXxj4Q+QGFGybqeNys8RA1p+8W1Nsmo6xPiUD280C7OOysMi2lqserqiIAIyhXhqGL1NcM7HYmL7ZZbLNLKalFqcq6ywWf6Fh/yNrt2SPiOp+PfzaKLlGhI=
Message-ID: <445E4D86.8000103@gmail.com>
Date: Sun, 07 May 2006 21:41:58 +0200
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Al Viro <viro@ftp.linux.org.uk>, Arjan van de Ven <arjan@infradead.org>,
       Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC] minix_fs_v3 update corrected according to Al Viro
References: <445DEEAC.9060004@gmail.com> <20060507101744.2e636c05.akpm@osdl.org>
In-Reply-To: <20060507101744.2e636c05.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

you wrote:

> Please see Al's recent emails to linux-kernel.   Minix has
> serious problems which we'll need to sort through before
> adding features.

Yes, I have read them and those of Linus too.

No matter for me. I do not belong to the Minix team. I have been only 
entertaining myself with Minix for a while and I needed to mount it from Linux, 
so I wrote the patch and published it in my page:

http://www.terra.es/personal2/danarag

to help others with the same curiosity. If my patch can bee merged into the 
Linux Kernel mainline, good. If not, also good.

Keep it on the queue if you think it helpful. Otherwise, just drop it out.

Regards,

Signed-off-by: Daniel Aragones <danarag@gmail.com>




