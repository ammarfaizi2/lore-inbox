Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266120AbTLaFEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 00:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbTLaFEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 00:04:10 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:64945 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266120AbTLaFEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 00:04:08 -0500
Subject: Re: Bug in radeonfb (2.6.0)?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Bergeron <mberg24@hotmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Law11-F36EhXTwpb1iT0000d4bf@hotmail.com>
References: <Law11-F36EhXTwpb1iT0000d4bf@hotmail.com>
Content-Type: text/plain
Message-Id: <1072847016.730.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Dec 2003 16:03:37 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-31 at 15:09, Martin Bergeron wrote:
> Hi,
> 
> I just upgraded from kernel 2.6.0-test10 to 2.6.0 without changing anything 
> to my  existing configuration (make oldconfig, etc.).  After rebooting, the 
> console was completely unreadable, with garbage all over the screen.  It was 
> working correctly in 1024x768 before and X still worked correctly.

Can you check if it works with the new radeonfb that is in

bk://ppc.bkbits.net/linuxppc-2.5-benh ?

(also available via rsync on source.mvista.com)

Ben.


