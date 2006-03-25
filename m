Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWCYR0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWCYR0g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 12:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWCYR0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 12:26:36 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:57392 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750861AbWCYR0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 12:26:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=SIJCN6dd7OSRGv634L9ZJ3LygC1gX6hFbQOCyRmHdQVTQYF+sZeDdHhPVkxA/jMsrUPw0qP9GuwvJ0LZbSxjv7AkIOvgjTSI+WzlFXHH5kIuT/LkdIphuK9QAmK5GPWegvVYG19uvISQUHClhRFu9Klvxmt7BqYpCdF61W1q4y0=
Message-ID: <44257E44.70302@gmail.com>
Date: Sun, 26 Mar 2006 00:30:44 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Amit Luniya <amit_31_08@yahoo.co.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: Help related to socket creation in kernel space
References: <20060325050910.25509.qmail@web8705.mail.in.yahoo.com>
In-Reply-To: <20060325050910.25509.qmail@web8705.mail.in.yahoo.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Amit Luniya wrote:
> Hello sir,
>       I am final year student of comp. engg. from pune
> university. My project is hibernation in network
> environment. Existing utility of hibernation using
> "swsusp.c" does not support ping operation or any
> other n/w related services after resume. 
>   Tell me whether could we create socket in code of
> resume in such a way that we can get image back from
> server? As ping is application layer program does not
> support operation after resume , so could we do
> creation of socket and write kernel level network
> program in resume process and can communicate with
> server?
>  We are working on linux kernel 2.6.14.5 .
> Please help us as we are hang over our project.
> Have a good day sir.....

And the last thing, I don't know if network codes is legal in resume
process or not.

Mikado.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJX5ENWc9T2Wr2JcRAsheAJ94lPaw0Gn3B+D5JxyRYFapf6n3TQCg0GQX
Br6DYoO+f6w+rE+c3cZ4pWY=
=zYv4
-----END PGP SIGNATURE-----
