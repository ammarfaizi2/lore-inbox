Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbUAQNn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 08:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUAQNn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 08:43:26 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:21211 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S265493AbUAQNmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 08:42:49 -0500
Date: Sat, 17 Jan 2004 13:38:45 +0000
From: backblue <backblue@netcabo.pt>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: a7n8x-x
Message-Id: <20040117133845.3fa95ef6.backblue@netcabo.pt>
In-Reply-To: <200401171428.03300.bzolnier@elka.pw.edu.pl>
References: <20040117102229.4747e7f8.backblue@netcabo.pt>
	<200401171308.48641.bzolnier@elka.pw.edu.pl>
	<20040117130935.7fd0212c.backblue@netcabo.pt>
	<200401171428.03300.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2004 13:42:48.0553 (UTC) FILETIME=[CB815D90:01C3DCFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I can make a downgrade to my bios, i hope it helps someone!
It locks up in diferente weird ways, sometimes when booting, but almost appends when very much access to de disc! I will do the lspci and will send it to the lkml!

On Sat, 17 Jan 2004 14:28:03 +0100
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

> On Saturday 17 of January 2004 14:09, you wrote:
> > Here it is, lspci with version 1007, i dont have way to get a lspci with
> 
> You forgot to attach it :-).
> 
> > older version, but i think, if someone report some problem, just ask to the
> > guy the lspci and check the diferences! If you need anymore thing, just ask
> > me, i have ide and scsi stuff, and my computer works great, i think if is a
> > bios upgrade solved the problem, maybe the problem it's not on linux
> > kernel. i dont change anything in the kernel, and it works great.
> 
> You might probably downgrade BIOS and get lspci output if it kernel doesn't
> lockup immediately during boot.  Someone else may have different settings
> so PCI config will differ.
> 
