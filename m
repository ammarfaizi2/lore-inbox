Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274683AbSITC1L>; Thu, 19 Sep 2002 22:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274684AbSITC1L>; Thu, 19 Sep 2002 22:27:11 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:11396
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S274683AbSITC1K>; Thu, 19 Sep 2002 22:27:10 -0400
Message-ID: <3D8A88B4.2050706@redhat.com>
Date: Thu, 19 Sep 2002 19:32:20 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <Pine.LNX.4.44L.0209192323530.1857-100000@imladris.surriel.com>
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rik van Riel wrote:

> I agree, it's pretty silly. But still, I was curious how they
> managed to achieve it ;)

Ingo will be able to tell you when he gets up.  This is not my area of 
expertise.  AFAIK there were no special changes involved; Ben's irq 
stack patch would add to this number (I think Ingo said something about 
188,000 threads or so).

- -- 
- ---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9ioi02ijCOnn/RHQRAnw+AJ9fFu36D8ZIk2Y3NC8Rpekb5EXwPwCePCBL
Z/u1XIdgB2F/UuixLkIpNvI=
=Ldzx
-----END PGP SIGNATURE-----

