Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTDFNV6 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTDFNV6 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:21:58 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:1711 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261702AbTDFNV5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 09:21:57 -0400
Date: Sun, 6 Apr 2003 23:33:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Anant Aneja" <anantaneja@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: poweroff problem
Message-Id: <20030406233319.042878d3.sfr@canb.auug.org.au>
In-Reply-To: <20030405060804.31946.qmail@webmail5.rediffmail.com>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Apr 2003 06:08:04 -0000 "Anant Aneja" <anantaneja@rediffmail.com> wrote:
>
> I've got a problem with my 2.4.2-2 kernel.
> after reaching the power down stage i get a :
> 1. complete listing of the cpu registers
> 2. a message saying sementaion fault with halt -i -p -d

Has it always done this?

> i contacted the author of the poweroff script but
> he says that this means it must be a kernel problem

More likely a BIOS problem that is weel known.

> also i cant give u the complete listing of the cpu
> registers since it occurs at the last stage
> of shutdown and i cant copy it to a file
> and am too lazy to write it down

Write down the first few lines at least ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
