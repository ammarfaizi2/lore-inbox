Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVCDOrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVCDOrW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVCDOrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:47:21 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:47383 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261410AbVCDOrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:47:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eDFy466q56/p/MZPlfZdinz/aA+hhd49cbv4YhBsmegtaoUu9McnIeDD0JiC5w776vLc8U+5kmWKPELNLuQk1H/XFeiQeYgb3Cnsqi4fm1Gc71LU6sm+MIa0lQRrJhv1sg6QovpBCPGUv9yW9anBOavOvLEbmY0qOSjlBHuJ/8Y=
Message-ID: <65258a58050304064710b403d7@mail.gmail.com>
Date: Fri, 4 Mar 2005 15:47:10 +0100
From: Vincent Vanackere <vincent.vanackere@gmail.com>
Reply-To: Vincent Vanackere <vincent.vanackere@gmail.com>
To: Con Kolivas <kernel@kolivas.org>, axboe@suse.de
Subject: Re: 2.6.11-ck1 (cfq-timeslice)
Cc: ck@vds.kolivas.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200503030030.29722.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200503030030.29722.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Added since 2.6.10-ck7:
> +cfq-ts-21.diff
> The latest version of Jens' cfq-timeslice i/o scheduler now heavily tested and
> with full read i/o priority support

Speaking of the cfq-timeslice scheduler, is there a version that
applies to recent -mm kernels ?
(I cannot find anything more recent than 2.6.10-rc3-mm1).
I'd really love to try it again as it made quite a noticeable
difference last time I've tried (but I can't live without reiser4 any
more...).

Best regards,

Vincent
