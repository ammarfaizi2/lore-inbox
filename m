Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315581AbSECHc7>; Fri, 3 May 2002 03:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315585AbSECHc6>; Fri, 3 May 2002 03:32:58 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:35758 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S315581AbSECHc5>;
	Fri, 3 May 2002 03:32:57 -0400
Date: Fri, 3 May 2002 17:32:18 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dnotify oddity in 2.4.19pre6aa1
Message-Id: <20020503173218.00ed98dc.sfr@canb.auug.org.au>
In-Reply-To: <200204231658.g3NGwE203196@athlon.cichlid.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002 09:58:14 -0700 Andrew Burgess <aab@cichlid.com> wrote:
>
> I am seeing something very strange with the dnotify feature in kernel
> 2.4.19pre6aa1. I'm developing a file copy daemon that makes backups of
> files as soon as they change so I run dnotify on every directory in my
> system (essentially). I based my program on the example in dnotify.txt
> in the Documentation directory.

Do you have the same problems on 2.4.18 or 2.4.19pre8?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
