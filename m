Return-Path: <linux-kernel-owner+w=401wt.eu-S932447AbXAIVcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbXAIVcJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXAIVcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:32:09 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45649 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932443AbXAIVcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:32:08 -0500
Date: Tue, 9 Jan 2007 13:31:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
Message-Id: <20070109133121.194f3261.akpm@osdl.org>
In-Reply-To: <20070109214421.281ff564.khali@linux-fr.org>
References: <20070109102057.c684cc78.khali@linux-fr.org>
	<20070109170550.AFEF460C343@tzec.mtu.ru>
	<20070109214421.281ff564.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 21:44:21 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> So, Linus, Andrew, can you please take a look and revert or fix what
> needs to be?

Am afraid to touch it.  Sam should be back on deck soon and will hopefully
have time to fix this stuff up.

> This new behavior of the kernel build system is likely to
> make developers angry pretty quickly.

That might motivate them to fix it ;)
