Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbUKHRPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbUKHRPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbUKHRPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:15:19 -0500
Received: from colino.net ([213.41.131.56]:6910 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261959AbUKHQ5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:57:11 -0500
Date: Mon, 8 Nov 2004 17:56:38 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: linux-os@analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: insmod module-loading errors, Linux-2.6.9
Message-ID: <20041108175638.2b3da7b3.colin.lkml@colino.net>
In-Reply-To: <Pine.LNX.4.61.0411081007530.3682@chaos.analogic.com>
References: <Pine.LNX.4.61.0411081007530.3682@chaos.analogic.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs141.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Nov 2004 at 10h11, linux-os wrote:

Hi, 

> Please restore the "-f" parameter passed to insmod. It
> was there for a very good reason. This allows one
> who encounters the module-loading error while installing
> the kernel to force the module loading. In this way, the
> correct modules are used to generate the new `initrd` image.

Wouldn't using the EXTRAVERSION field save you from such hassles?

-- 
Colin
