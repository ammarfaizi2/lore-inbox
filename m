Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWATRQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWATRQH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWATRQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:16:07 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:26467 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751096AbWATRQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:16:06 -0500
Message-ID: <BAYC1-PASMTP02748FE950A9EFB4BAB4CFAE1F0@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Fri, 20 Jan 2006 12:11:16 -0500
From: sean <seanlkml@sympatico.ca>
To: Michael Loftis <mloftis@wgops.com>
Cc: James@superbug.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-Id: <20060120121116.62a8f0a6.seanlkml@sympatico.ca>
In-Reply-To: <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	<43D10FF8.8090805@superbug.co.uk>
	<6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2006 17:16:05.0782 (UTC) FILETIME=[32740B60:01C61DE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2006 09:36:35 -0700
Michael Loftis <mloftis@wgops.com> wrote:

> Yes I realise this change isn't out of the blue or anything, but it's in a 
> 'stable' kernel.  Why bother calling 2.6 stable?  We may as well have 
> stayed at 2.5 if this sort of thing is going to continue to be pulled.
> 

Most of your message seems to boil down to complaining that devfs has been removed.
Unfortunately your frustration is pointed in the wrong direction; you should be
asking yourself why you ignored all those warnings about devfs removal for so long.
If you really need it, just use the 2.4 kernel; it's very stable.

If you want to complain about the current tree being called "stable", then just
don't call it stable.   Call it the development tree because in the end that's what 
it is.  No need to get hung up on a name; it is what it is.  Anyone, is free to fork
a real stable tree just like some distributions do.   But such "stable" trees just 
aren't going to be maintained by the same people who develop the mainline; they have
enough to do already.

If you can think of an idea to solve your problem without demanding that other people 
(ie. the mainline developers) do extra work, then speak up.   But just demanding that
the developers patch a stable tree while working on the development branch as well,
has other _real_ costs that precipitated the shift to the current model.

Sean
