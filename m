Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTJRR64 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTJRR6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:58:55 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:2016 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261773AbTJRR6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:58:20 -0400
Subject: Re: 'drivers/block/swim3.c' fails to compile under 2.6.0-test8
	[Bug #1370]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Mock <kd6pag@qsl.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1AAv3q-0000wq-00@penngrove.fdns.net>
References: <E1AAv3q-0000wq-00@penngrove.fdns.net>
Content-Type: text/plain
Message-Id: <1066499840.646.278.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 18 Oct 2003 19:57:21 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-10-18 at 19:40, John Mock wrote:
> Also fails at least back to 'test3'.  It seems at least to be missing
> some #include files.  I've not had a chance to test the actual driver
> as the framebuffer console won't sync for me under '2.6.0-test8' and
> currently fails to come up far enough to allow 'ssh' access.  Attached
> is a possible patch, which still gets a couple of warnings.  See
> 
>     http://bugzilla.kernel.org/attachment.cgi?id=1090
> 
> for .config file.

I'll take care of this one

Ben.


