Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274065AbRIXRVg>; Mon, 24 Sep 2001 13:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274054AbRIXRV1>; Mon, 24 Sep 2001 13:21:27 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:2568 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274065AbRIXRVQ>;
	Mon, 24 Sep 2001 13:21:16 -0400
Date: Mon, 24 Sep 2001 10:17:10 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010924101710.C7311@kroah.com>
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010924124044.B17377@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 12:40:44PM -0400, Arjan van de Ven wrote:
> Highlevel drivers
> -----------------
> Hewlet Packard	- High level security modules (LSM)
> SGI 		- High level security modules (LSM)
> Wirex		- High level security modules (LSM)

For those interested in the current LSM licensing issues, feel free to
join the discussion on the linux-security-module-list:
	http://mail.wirex.com/mailman/listinfo/linux-security-module

The thread can be read online starting at:
	http://mail.wirex.com/pipermail/linux-security-module/2001-September/thread.html#2017
with the title:
	GPL only usage of security.h

thanks,

greg k-h
