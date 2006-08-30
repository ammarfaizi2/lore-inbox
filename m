Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWH3NIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWH3NIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 09:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWH3NIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 09:08:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:48906 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750990AbWH3NIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 09:08:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SzEiTi0jhEmmep/fSaJocKWsnN9lYk9aXxa8fI2AnpsRxzJGLyYKMqXiCx5/Re+IqHwjIjVz1h+c/io4XOdhfLqQYArtznQIfgkLgaixduIJMnvWGHgeOg6+7Ysep0FPLMPN76UR/gLa/KbuuvEsSLDuo+NuiVZir0NeXOtITk8=
Message-ID: <6bffcb0e0608300608s2bf3bac5mbd582f3cb77be7c@mail.gmail.com>
Date: Wed, 30 Aug 2006 15:08:49 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mm snapshot broken-out-2006-08-29-23-43.tar.gz uploaded
Cc: mm-commits@vger.kernel.org
In-Reply-To: <200608300645.k7U6jXjR013216@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608300645.k7U6jXjR013216@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> The mm snapshot broken-out-2006-08-29-23-43.tar.gz has been uploaded to
>
>    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-29-23-43.tar.gz
>
> It contains the following patches against 2.6.18-rc5:
[..]
> git-dvb-fixup.patch

This patch should be updated.

Applying patch patches/git-dvb-fixup.patch
The next patch would create the file include/media/v4l2-dev.h,
which already exists!  Applying it anyway.
patching file include/media/v4l2-dev.h
Patch attempted to create file include/media/v4l2-dev.h, which already exists.
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- rejects in file include/media/v4l2-dev.h
patching file drivers/media/radio/Kconfig
patching file drivers/media/video/compat_ioctl32.c
Patch patches/git-dvb-fixup.patch does not apply (enforce with -f)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
