Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUBEQQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUBEQQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:16:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:43174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265362AbUBEQQZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:16:25 -0500
Date: Thu, 5 Feb 2004 08:18:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Luis Miguel =?ISO-8859-1?B?R2FyY+1h?= <ktech@wanadoo.es>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-Id: <20040205081810.7116be92.akpm@osdl.org>
In-Reply-To: <40223089.8050607@wanadoo.es>
References: <40223089.8050607@wanadoo.es>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Miguel García <ktech@wanadoo.es> wrote:
>
> Andrew Morton wrote:
> 
> >
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2/2.6.2-mm1/ 
> >>
> >>
> >>
> >> - Merged some page reclaim fixes from Nick and Nikita.  These yield some
> >>  performance improvements in low memory and heavy paging situations.
> >>
> >>
> 
> Andrew, do you know if this acpi pull down has nforce support fixed?

It doesn't appear that way.

> Or perhaps it's even unnotified to the acpi team?

I do not know.  Sending them a bugzilla ID would help, if such a thing exists.

