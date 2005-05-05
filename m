Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVEETtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVEETtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVEETsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:48:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:38100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262193AbVEETkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:40:32 -0400
Date: Thu, 5 May 2005 12:39:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: torvalds@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [git pull] jfs update
Message-Id: <20050505123953.4a45a834.akpm@osdl.org>
In-Reply-To: <1115319068.8473.5.camel@localhost>
References: <20050504204744.DA0A0849AD@kleikamp.dyn.webahead.ibm.com>
	<Pine.LNX.4.58.0505041437060.2328@ppc970.osdl.org>
	<427A630E.5000008@pobox.com>
	<Pine.LNX.4.58.0505051119440.2328@ppc970.osdl.org>
	<1115319068.8473.5.camel@localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> wrote:
>
> Andrew,
>  You can pull:
> 
>  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-mm
> 
>  whenever you do an -mm build.  If your scripts have a problem with that,
>  you might try
> 
>  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git#for-mm

Neither of those work for me, which I guess means that I have to go and
update all my git stuff, whcih will break every darn thing.  Ho hum.
