Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265235AbSJRVjZ>; Fri, 18 Oct 2002 17:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265324AbSJRVjZ>; Fri, 18 Oct 2002 17:39:25 -0400
Received: from mail.firstinspire.net ([212.83.62.162]:4740 "EHLO
	NS.firstinspire.net") by vger.kernel.org with ESMTP
	id <S265235AbSJRVjZ>; Fri, 18 Oct 2002 17:39:25 -0400
Date: Fri, 18 Oct 2002 23:45:19 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: Re: patch for linux/usb.h
Message-ID: <20021018214519.GF32609@net-m.de>
References: <20021018212532.GE32609@net-m.de> <20021018213521.GA10351@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018213521.GA10351@kroah.com>
User-Agent: Mutt/1.4i
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.4.20-pre5 i586
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, finger me at johoho@212.83.62.165 or send an email with the subject 'public key request' to wodecki@gmx.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +} urb_t;
> > -};
> 
> No, that's not "missing" it was taken out because it should have never
> gotten there in the first place.

hmmm, it might "not be a good thing" to change an interface in a stable
kernel series. this, for example, broke my quickcam express video cam
driver. It might be wrong there, however I think we should leave it
there...not apply this to 2.5 then

-- 
Regards,

Wiktor Wodecki      |    http://johoho.eggheads.org
