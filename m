Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUHRR26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUHRR26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 13:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUHRR26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 13:28:58 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:1419 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267362AbUHRR24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 13:28:56 -0400
Date: Wed, 18 Aug 2004 19:28:55 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.05
Message-ID: <20040818172855.GC14628@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040818125104.GA12286@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818125104.GA12286@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 02:51:04PM +0200, Herbert Poetzl wrote:
> 
> Greetings!
> 
> The following patch extends the 'noatime', 'nodiratime' and
> last but not least the 'ro' (read only) mount option to the
> vfs --bind mounts, allowing them to behave like any other
> mount, by honoring those mount flags (which are silently
> ignored by the current implementation in 2.4.x and 2.6.x)
> 
> I don't want to pollute your mailbox with useless patches,
> so for those who are interested in this stuff, get them
> here (for 2.4.27 and 2.6.8.1)

patch for 2.6.8.1 is broken, but it will be updated soon
please don't use it for now ...

TIA,
Herbert

>   http://www.13thfloor.at/patches/
> 
> many thanks to Willy Tarreau for spotting the bug in the
> previous bme0.04 for linux 2.4.x.
> 
> enjoy,
> Herbert
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
