Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135621AbRDXXIG>; Tue, 24 Apr 2001 19:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135634AbRDXXH5>; Tue, 24 Apr 2001 19:07:57 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:11783 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S135621AbRDXXHs>; Tue, 24 Apr 2001 19:07:48 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: compile error 2.4.4pre6: inconsistent operand constraints in an
In-Reply-To: <9c3pgm$u0$1@ns1.clouddancer.com>
In-Reply-To: <Pine.LNX.4.21.0104241350230.8659-100000@neon.rayfun.org> <E14rpIA-0000iK-00@the-village.bc.nu> <9c3pgm$u0$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010424230742.0C1906808@mail.clouddancer.com>
Date: Tue, 24 Apr 2001 16:07:42 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In list.kernel, axel <axel@rayfun.org> wrote:
>
>How about correcting the needed gcc version in Documentation/Changes?


Linux, with up to date documention??  In your dreams perhaps.


>On Mon, 23 Apr 2001, Alan Cox wrote:
>
>> > after having had trouble with compilation due to old gcc version, i have
>> > updated to gcc 3.0 and received the following error:
>> 
>> 2.4.4pre6 only builds with gcc 2.96. If you apply the __builtin_expect fixes
>> it builds and runs fine with 2.95. Not tried egcs. The gcc 3.0 asm constraints
>> one I've yet to see a fix for.


BTW.  The above attitude was fostered by informing the Changes
maintainer that the recommended NFS userspace server was on the
exploits list (back in the 2.0 kernel days when knfs was new) and
getting a "I don't use that, so what" response.

...and the documentation continued to recommend an exploitable NFS
server... in short: you must cross-check to be sure, at least in linux
you have a few more options.


