Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVIUOut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVIUOut (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVIUOut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:50:49 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:888 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751024AbVIUOus convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:50:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c8LOyUao67Jur7NzFyRohdYWNPxkJrqLazueUNwOS/eoLcBywT7oObLs7rEnZceI8ZtVxTdVsGCjrk9pyHCMD3aIwSItiQSR7a/cm4wRUfD7WgcaFfz0ij7N084vdF8ydblcUyfjhaVPoO0bXjjOvselwIQ+tJLcZDoH3OsW/L0=
Message-ID: <4ae3c14050921075031fced13@mail.gmail.com>
Date: Wed, 21 Sep 2005 10:50:48 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: Is stack back trace possible if compiled with -fomit-frame-pointer?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4331746F.9010500@stesmi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140509210737383422b3@mail.gmail.com>
	 <4331746F.9010500@stesmi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

But I am looking for a tool or method to do stack backtrace
automatically, not debug manually.

The tool listed on http://www.aivosto.com/visustin.html can only
generate control flow from source code. But I need a control flow
generator that can generate control flow from binary codes. One
example is EEL (Executable Edit Library). But it only works for SPARC
machine, not PC. :(

As for the question about the kernel development list, I am developing
a kernel module that supports stack backtrace and can analyze user app
binaries to enforce security policies. So this is still related to
Kernel development. :)

Xin

On 9/21/05, Stefan Smietanowski <stesmi@stesmi.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Xin Zhao wrote:
> > Also, I might want to know whether it is common case that linux apps
> > are compiled with  -fomit-frame-pointer swtich?
>
> This is the Linux KERNEL development list.
>
> Not Linux USERSPACE development list.
>
> Find an appropriate list and ask your question there please.
>
> // Stefan
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (MingW32)
>
> iD8DBQFDMXRvBrn2kJu9P78RAtlSAJwOMuF3mA9oxQO6nLwsHTCmf9lngACgkfOQ
> XMpu/ZFfdokiJ7jFSRCpvvQ=
> =Q3QR
> -----END PGP SIGNATURE-----
>
