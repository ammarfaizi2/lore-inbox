Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbSJ3Baz>; Tue, 29 Oct 2002 20:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSJ3Baz>; Tue, 29 Oct 2002 20:30:55 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:14094 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262810AbSJ3Bay>; Tue, 29 Oct 2002 20:30:54 -0500
Date: Tue, 29 Oct 2002 14:47:22 -0600
From: Courtney Grimland <cgrimland@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: agp_try_unsupported=1
Message-Id: <20021029144722.2632cac2.cgrimland@yahoo.com>
In-Reply-To: <20021029144214.13a83df0.cgrimland@yahoo.com>
References: <20021029144214.13a83df0.cgrimland@yahoo.com>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Real Men Don't Use Distros - www.linuxfromscratch.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry - I meant with agpgart built as a module vs. built into the
kernel.



On Tue, 29 Oct 2002 14:42:14 -0600
Courtney Grimland <cgrimland@yahoo.com> wrote:

> Stock 2.4.19
> VIA KT400 Northbridge
> VIA VT8235 Southbridge
> Radeon 7500
> 
> Why does this only work as an argument to modprobe with via82cxxx built
> as a module, but not as a parameter to lilo with the same driver built
> in to the kernel?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
