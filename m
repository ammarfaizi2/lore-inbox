Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317643AbSGOVYM>; Mon, 15 Jul 2002 17:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317647AbSGOVYL>; Mon, 15 Jul 2002 17:24:11 -0400
Received: from [209.184.141.189] ([209.184.141.189]:58933 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317643AbSGOVYK>;
	Mon, 15 Jul 2002 17:24:10 -0400
Subject: Re: Some sysctl parameter change questions.
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1026763622.14848.0.camel@UberGeek>
References: <1026763622.14848.0.camel@UberGeek>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 15 Jul 2002 16:26:58 -0500
Message-Id: <1026768418.14850.12.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI on this. I'm not having any particular problem per se, I'm just
trying to tune for my DB as best I can and watch the performance stats
of various operations. So, please don't be hindered, if you have
anything to say about these items, that I didn't specify a problem.
There isn't a real *problem* ATM.

On Mon, 2002-07-15 at 15:07, Austin Gonyou wrote:
> Looking through some tuning documentation about sysctl values as related
> to Oracle and other DB tuning bits, I noticed that the following don't
> exist anymore, and was curious where or if they were moved.
> 
> /proc/sys/kernel/inode-max
> /proc/sys/vm/freepages
> 
> In coincidence with this info, I was curious if anyone has tweaked the
> following and if it makes any difference, with regard to performance:
> 
> /proc/fs/pagebuf
> /proc/sys/vm/pagebuf
> /proc/sys/vm/pagebuf/max_dio_pages
> /proc/sys/vm/page-cluster
> /proc/sys/vm/pagetable_cache
> 
> 
> -- 
> Austin Gonyou <austin@digitalroadkill.net>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
