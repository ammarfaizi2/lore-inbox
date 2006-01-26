Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWAZVEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWAZVEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWAZVEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:04:55 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:43658 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964876AbWAZVEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:04:54 -0500
Date: Thu, 26 Jan 2006 22:04:53 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] vfs: propagate mnt_flags into do_loopback/vfsmount
Message-ID: <20060126210453.GA22020@MAIL.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060121083843.GA10044@MAIL.13thfloor.at> <20060121084055.GC10044@MAIL.13thfloor.at> <20060124190256.GA14201@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124190256.GA14201@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 07:02:56PM +0000, Christoph Hellwig wrote:
> This one looks good, it's an obvious fix.  But please follow the proper
> patch format, see http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
> for details.

huh? please help me figure out what's wrong this time ...

TIA,
Herbert

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
