Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUBSWWw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267579AbUBSWWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:22:51 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:27623 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S267582AbUBSWWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:22:33 -0500
Date: Thu, 19 Feb 2004 23:24:54 +0100
From: Julien COMBES ML <j.combes.ml@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange problem with alsa, emu10k1 and ut2003 on 2.6.3
Message-Id: <20040219232454.02abe594.j.combes.ml@free.fr>
In-Reply-To: <E1Atqi4-0000BM-7q@torg>
References: <1077197950.4034bc7ec9730@imp1-q.free.fr>
	<E1Atqi4-0000BM-7q@torg>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 11:07:32 -0500
Tyler Trafford <ttrafford@acm.org> wrote:

> This is a problem with the openal.so library that comes with UT2003. 
> To fix it you can replace it with one from America's Army or UT2004;
> or you can just compile yourself a new one from cvs (www.openal.org).

I have tested your solution, it work perfectly.

Moreover, I test xmms with ogg like suggested, It works fine and doesn't
eat CPU in my case (it uses less than 1%).

Thanks to all.

Regards,
Julien
