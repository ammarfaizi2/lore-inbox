Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAZGfO>; Fri, 26 Jan 2001 01:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbRAZGfF>; Fri, 26 Jan 2001 01:35:05 -0500
Received: from m2.deja.com ([64.57.169.64]:13352 "EHLO m2.deja.com")
	by vger.kernel.org with ESMTP id <S129523AbRAZGfA>;
	Fri, 26 Jan 2001 01:35:00 -0500
Message-Id: <200101260634.AAA02715@x57.deja.com>
From: qkholland@my-deja.com
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0 loop device still hangs
Date: Fri, 26 Jan 2001 06:34:52 GMT
Newsgroups: fa.linux.kernel
NNTP-Posting-Host: 24.5.157.48
Organization: Deja.com
In-Reply-To: <fa.hl5rjsv.1b78u0u@ifi.uio.no>
X-Article-Creation-Date: Fri Jan 26 06:34:52 2001 GMT
X-Http-Proxy: 1.0 lynx:3128 (Squid/2.3.STABLE4-hno.20000819), 1.0 x64.deja.com:80 (Squid/1.1.22) for client 192.168.7.1, 24.5.157.48
X-Http-User-Agent: unknown
X-MyDeja-Info: XMYDJUIDqkholland
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fa.hl5rjsv.1b78u0u@ifi.uio.no>,
  Mark Bratcher <mbratche@rochester.rr.com> wrote:
> I saw a post dated last fall 2000 sometime about the
> loop device hanging when copying large amounts of data
> to a file mounted as, say, ext2fs.

I've recently reported a similar problem and told by
Jens Axboe at SUSE that it is still there, and appears
to be generic (not hardware nor kernel configuration
specific) problem.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
