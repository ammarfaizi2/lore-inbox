Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTIVFkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 01:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTIVFkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 01:40:55 -0400
Received: from dyn-ctb-203-221-73-213.webone.com.au ([203.221.73.213]:13838
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262985AbTIVFky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 01:40:54 -0400
Message-ID: <3F6E8B64.2000905@cyberone.com.au>
Date: Mon, 22 Sep 2003 15:40:52 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Nick's scheduler policy v15a
References: <3F608807.9090705@cyberone.com.au>
In-Reply-To: <3F608807.9090705@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/v15a/

No changes apart from a sync with Linus' tree now that it includes Con's
stuff. It basically just reverts the patches that have gone in. I'm not
sure what the right way to do this would be, but it seems cleaner than to
wade through the remains of my patches after a brute force merge.

This still has known SMP regressions that I haven't got around to looking
at yet because there has been a bit of trouble with a big box I'm supposed
to get time on.

I am still not aware of any desktop / interactivity problems so tell me if
you find any.



