Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTIWAXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTIWAXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:23:40 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:38077 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S262794AbTIVXx6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:53:58 -0400
Date: Tue, 23 Sep 2003 09:53:32 +1000
From: David McCullough <davidm@snapgear.com>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: gerg@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix memory leaks in binfmt_flat.c
Message-ID: <20030922235332.GA6861@beast>
References: <E1A1WsY-000Gjr-00.adobriyan-mail-ru@f16.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A1WsY-000Gjr-00.adobriyan-mail-ru@f16.mail.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin "Alexey Dobriyan"  lays it down ...
> Fix memory leaks in /fs/binfmt_flat.c::decompress_exec()

Applied to the uClinux-2.4 source and all our sources,

Thanks,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
