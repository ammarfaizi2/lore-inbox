Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267865AbTAMMaT>; Mon, 13 Jan 2003 07:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267872AbTAMMaT>; Mon, 13 Jan 2003 07:30:19 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:61418 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267865AbTAMMaS>;
	Mon, 13 Jan 2003 07:30:18 -0500
Date: Mon, 13 Jan 2003 23:38:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] compat_sys_[f]statfs - s390x part
Message-Id: <20030113233844.539fabac.sfr@canb.auug.org.au>
In-Reply-To: <OFC74FD0A9.9C22AA34-ONC1256CAD.0031FD29@de.ibm.com>
References: <OFC74FD0A9.9C22AA34-ONC1256CAD.0031FD29@de.ibm.com>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, 13 Jan 2003 10:11:20 +0100 "Martin Schwidefsky" <schwidefsky@de.ibm.com> wrote:
>
> Looks fine to me. I can't test it at the moment because the s390x compat
> stuff is broken right now. Not because of your patches but other things
> need fixing. I'll have a go at it as soon as I'm through with the TLS
> stuff for binutils and glibc. Keep up with it, I'm happy about every
> line of code that is moved out of the arch/s390* folders.

Thanks, wiil do.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
