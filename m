Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbTAUFCF>; Tue, 21 Jan 2003 00:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTAUFCB>; Tue, 21 Jan 2003 00:02:01 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:48813 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261872AbTAUFB7>;
	Tue, 21 Jan 2003 00:01:59 -0500
Date: Tue, 21 Jan 2003 16:09:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: ralf@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: Minor header bug? MIPS (32-bit) nlink_t sign
Message-Id: <20030121160959.6e392885.sfr@canb.auug.org.au>
In-Reply-To: <20030118033435.GC18282@bjl1.asuk.net>
References: <20030118033435.GC18282@bjl1.asuk.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

On Sat, 18 Jan 2003 03:34:35 +0000 Jamie Lokier <jamie@shareable.org> wrote:
>
> Stephen, I guess you have already figured this out with your recent
> 32-bit compatibility cleanup?

I mainly did direct substitutions, but will have a look shortly and see
what I think.

I assume we are being compatable with Irix? Ralf?
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
