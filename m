Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129288AbRBSUK1>; Mon, 19 Feb 2001 15:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbRBSUKS>; Mon, 19 Feb 2001 15:10:18 -0500
Received: from jkd.penguinfarm.com ([12.32.79.69]:14340 "HELO
	jkd.penguinfarm.com") by vger.kernel.org with SMTP
	id <S129288AbRBSUKJ>; Mon, 19 Feb 2001 15:10:09 -0500
Content-Type: text/plain;
  charset="US-ASCII"
From: Jason Straight <junfan@penguinfarm.com>
To: Admin Mailing Lists <mlist@intergrafix.net>
Subject: Re: Journaled FS on RAID stability..2.4?
Date: Mon, 19 Feb 2001 15:09:07 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10102191458120.18450-100000@athena.intergrafix.net>
In-Reply-To: <Pine.LNX.4.10.10102191458120.18450-100000@athena.intergrafix.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01021915090700.00979@jkd.penguinfarm.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 February 2001 14:58, Admin Mailing Lists wrote:
> Can anyone give testimonials on a journaled FS on software-raid?
> I'd like to raid-0 2 SCSI 18Gers, adaptec 2940 u2w controller, kernel
> 2.4.x.
> Also pros and cons for reiser-fs/ext3 on this solution would be
> appreciated
>
> Thanx,
>
> -Tony
> .-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
> Anthony J. Biacco                       Network Administrator/Engineer
> thelittleprince@asteroid-b612.org       Intergrafix Internet Services
>
>     "Dream as if you'll live forever, live as if you'll die today"
> http://www.asteroid-b612.org                http://www.intergrafix.net
> .-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I am running squid on a dual 533 celeron with 4 7200RPM 40GB IBM IDE drives, 
using kernel 2.4.1 and reiserfs for a couple weeks now. Seems good - only got 
30GB on it right now.



-- 
Jason Straight
