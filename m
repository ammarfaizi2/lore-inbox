Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVCIU6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVCIU6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVCIUy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:54:57 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:53350 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262470AbVCIUvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:51:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pXnPQP5LNBtrYwf3Rsc3ptY8TKm0+Wmay8zZqdzeeRhK/eAVw2kG8x3f0053tyoEjnXPesk14nTCJUrlVjVLjBGV1dBZtxkyb9Syay83pji878DNdTkRuMDe325ZurDcJLGKm7UoxSzwPCMx9/DMQ/kJvN4DcbengdPboHrhm9E=
Message-ID: <9e473391050309125118f2e979@mail.gmail.com>
Date: Wed, 9 Mar 2005 15:51:21 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: current linus bk, error mounting root
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <422F5D0E.7020004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105030909031486744f@mail.gmail.com>
	 <422F2F7C.3010605@pobox.com>
	 <9e4733910503091023474eb377@mail.gmail.com>
	 <422F5D0E.7020004@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2005 15:31:10 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Well, there are no changes in libata from bk4 to present.  The only
> thing I see in the -bk4-bk5 increment diff that's immediately noticeable
> is the barrier stuff.

bk4 works
bk5 is broken

Where are these *.key files? Maybe I can do some more divide and
conquer in bitkeeper.

-- 
Jon Smirl
jonsmirl@gmail.com
