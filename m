Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWC2PVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWC2PVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWC2PVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:21:09 -0500
Received: from nproxy.gmail.com ([64.233.182.184]:25057 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751172AbWC2PVI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:21:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=okVWqBBBVggRgSpQRioWEFYeGBZBCAVHxY/X36WH0/98Pm9S4tpUtyaX/mEixmP5DKU3AEoAsUIQjnqdkSLJwvdTav/qhBSrVK09WYDQrU5ESIBXO5YgBjXbQ4O5SYaiE0uaMZT/raRYr2NkK4ZBxebzaLWa1P44NlOrLP7cco0=
Message-ID: <aad1205e0603290720s50901a76h@mail.gmail.com>
Date: Wed, 29 Mar 2006 23:20:56 +0800
From: Andyliu <liudeyan@gmail.com>
To: "Eric Persson" <eric@persson.tm>
Subject: Re: kernel config repository
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <442A99CA.20303@persson.tm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <442A99CA.20303@persson.tm>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

For ppc and ppc64, there are some config files:
arch/ppc/configs/ and arch/powerpc/configs/.

Seems none for i386.

2006/3/29, Eric Persson <eric@persson.tm>:
> Hi,
>
> I hope I'm not totally wrong here, but I figured this would be a good
> place to start, the kernel-config list seems a bit dead.
>
> I've been thinking about creating a community-driven .config repository,
> since I havent found any good place for this sort of information.
> I would see it as a place for people to contribute .configs for various
> hardware/platforms and keep them updated and current with the kernel
> releases.
>
> Perhaps this exist(i havent found any easily), or is considered a bad
> idea(please tell me), or is actually a good idea.
>
> Tell me what you think, sorry if I might have sent this to the wrong list.
>
> Keep up the good work.
>
> Best regards,
>     Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Andyliu
