Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262465AbTCIH2Q>; Sun, 9 Mar 2003 02:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbTCIH2Q>; Sun, 9 Mar 2003 02:28:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:8633 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262465AbTCIH2P>;
	Sun, 9 Mar 2003 02:28:15 -0500
Date: Sat, 8 Mar 2003 23:39:13 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: jason@jeetkunedomaster.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64bk3 no screen after Ok booting kernel
Message-Id: <20030308233913.02050257.akpm@digeo.com>
In-Reply-To: <200303090734.XAA01410@adam.yggdrasil.com>
References: <200303090734.XAA01410@adam.yggdrasil.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Mar 2003 07:38:47.0682 (UTC) FILETIME=[EB9F6E20:01C2E60E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> wrote:
>
> On another desktop computer (a P3), I get no kernel printk's but user
> level programs print their output.  For example I see fsck print its
> output.  However, that computer system hangs after fsck apparently
> finishes.  The computer with the console problems under 2.5.64bk3
> boots 2.5.64 and 2.5.64bk1 fine.  I haven't tried 2.5.64bk2 yet.
> 

Did you try adding "console=tty0" to the boot command?  That got broken too.

