Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVHHLs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVHHLs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbVHHLsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:48:25 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:35289 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750829AbVHHLsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:48:25 -0400
Date: Mon, 8 Aug 2005 21:48:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [HELP] How to get address of module
Message-Id: <20050808214822.531ee849.sfr@canb.auug.org.au>
In-Reply-To: <20050808.204022.30161255.kaminaga@sm.sony.co.jp>
References: <20050808.204022.30161255.kaminaga@sm.sony.co.jp>
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Aug 2005 20:40:22 +0900 (JST) Hiroki Kaminaga
<kaminaga@sm.sony.co.jp> wrote:
>
> I'm looking for *nice* way to get address of loaded module in 2.6.
> I'd like to know the address from driver.

Maybe explaining why you need the address of a module would help.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
