Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRAXKB7>; Wed, 24 Jan 2001 05:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAXKBt>; Wed, 24 Jan 2001 05:01:49 -0500
Received: from hermes.mixx.net ([212.84.196.2]:48134 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129375AbRAXKBg>;
	Wed, 24 Jan 2001 05:01:36 -0500
Message-ID: <3A6EA7FA.6B886277@innominate.com>
Date: Wed, 24 Jan 2001 11:01:30 +0100
From: Juri Haberland <juri.haberland@innominate.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: nbecker@fred.net
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 statd trouble
In-Reply-To: <x888zo29jyj.fsf@adglinux1.hns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nbecker@fred.net wrote:
> 
> linux-2.4.0
> 
> I have quite a lot of these log messages:
> 
> Jan 23 18:28:52 adglinux1 rpc.statd[1532]: gethostbyname error for adglinux1.hns.com
> Jan 23 18:28:52 adglinux1 rpc.statd[1532]: STAT_FAIL to adglinux1.hns.com for SM_MON of 139.85.108.141
> Jan 23 13:28:52 adglinux1 kernel: lockd: cannot monitor 139.85.108.141

Upgrade your nfs-utils to version 0.2.1

Greetings,
Juri

-- 
juri.haberland@innominate.com
system engineer                                         innominate AG
clustering & security                            the linux architects
tel: +49-30-308806-45   fax: -77            http://www.innominate.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
