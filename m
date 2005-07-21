Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVGUVui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVGUVui (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 17:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVGUVui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 17:50:38 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:52622 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261884AbVGUVug convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 17:50:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k4c4DH7PcUx3dm1m9V+lcrbloa//vjNa8BR6+xgMFydkbRhWm2L3+5ZB8ZahEqqjXmWCsTzs/pieDQ9l7BrqHPS/wK/07POmCKb8QRCHc8EfKc4As4EusrVjIhwN0iJ0cxSzfYzpzcJyM5iYPVRg3OZLe5s0rSXN0D6gDc8wETI=
Message-ID: <2de37a440507211450501a8378@mail.gmail.com>
Date: Thu, 21 Jul 2005 23:50:34 +0200
From: ioGL64NX <iogl64nx@gmail.com>
Reply-To: ioGL64NX <iogl64nx@gmail.com>
To: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen_/_Tronic?= 
	<tronic+lzID=lx43caky45@trn.iki.fi>
Subject: Re: Supermount
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42E00DD3.9060407@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <42E00DD3.9060407@trn.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>2005/7/21, Lasse Kärkkäinen / Tronic <tronic+lzID=lx43caky45@trn.iki.fi>:
> Is there a reason why this magnificient piece of software is not already
> in the mainline? It seems to be working very well and provides
> functionality that simply isn't available otherwise.
> 
Hi Tronic,

Supermount is obsolete there are other tools in userspace that do the
job perfectly.
e.g ivman which uses hal and dbus.

Including source like supermount because it simply work is not a good
argument. And why to hell should everthing in the kernel, to make
sorry *leazy* people happy? The kernel is not a trash...also
supermount uses ioctl which is nearly removed from kernel?! Please
correct me if i am wrong with ioctl.

Also there are other fs like supermount e.g submount etc...

> For those who are not familiar with it: this system does on-demand
> mounting when the mount point is accessed and automatically umounts
> afterwards. Unlike autofs, this does not require a special automount
> filesystem to be mounted, but the actual filesystems can be directly
> mounted where-ever. Also, it "just works" and the CD drive will eject
> when the button is pressed, without having to wait for the umount
> timeout to pass. I haven't looked inside to find out HOW it actually
> does it, because I simply don't care, as long as it just works.
I used supermount, too - for a long long time...but it cost me a
second to write a bash script with does supermount job's for eject.
;-)
> 
> - Tronic -
> 
> 
>
-- 
Mit freundlichen Grüßen
Michael Thonke

Best regards
Michael thonke
