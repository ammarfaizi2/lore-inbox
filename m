Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754642AbWKMNqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbWKMNqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 08:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbWKMNqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 08:46:36 -0500
Received: from smtpout07-01.prod.mesa1.secureserver.net ([64.202.165.230]:10724
	"HELO smtpout07-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1754642AbWKMNqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 08:46:36 -0500
Message-ID: <4558773A.4040803@seclark.us>
Date: Mon, 13 Nov 2006 08:46:34 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaun Q <shaun@c-think.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dual cores on Core2Duo not detected?
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
In-Reply-To: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaun,

Someone mentioned some bioses have an entry to enable the second core.

HTH,
Steve

Shaun Q wrote:

>Hi there everyone --
>
>I'm trying to build a custom kernel for using both cores of my new 
>Core2Duo E6600 processor...
>
>I thought this was simply a matter of enabling the SMP support in the 
>kernel .config and recompiling, but when the kernel comes back up, still 
>only one core is detected.
>
>With the default vanilla text-based SuSE 10.1 install, it does find both 
>cores...
>
>Anyone have any pointers for me on what I might be missing?
>
>Thanks!
>Shaun
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



