Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268140AbTBNVNP>; Fri, 14 Feb 2003 16:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268156AbTBNVNM>; Fri, 14 Feb 2003 16:13:12 -0500
Received: from x101-201-88-dhcp.reshalls.umn.edu ([128.101.201.88]:35970 "EHLO
	minerva") by vger.kernel.org with ESMTP id <S268140AbTBNVMj>;
	Fri, 14 Feb 2003 16:12:39 -0500
Date: Fri, 14 Feb 2003 15:22:31 -0600
From: Matt Reppert <arashi@yomerashi.yi.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: creating incremental diffs
Message-Id: <20030214152231.5a86d5ab.arashi@yomerashi.yi.org>
In-Reply-To: <Pine.LNX.4.51.0302142147360.12353@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0302142147360.12353@dns.toxicfilms.tv>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003 21:48:16 +0100 (CET)
Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:

> Hi,
> 
> let's say i want to create an incremental diff between
> 2.4.21pre4aa1 and aa2.
>
> how do I do that?

Make two trees, one with aa1, one with aa2. Diff them. (The "slow, painful"
method.)

You could also use interdiff from diffutils.

Matt
