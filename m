Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVCKXVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVCKXVH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVCKXUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:20:52 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:57389 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261726AbVCKXHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:07:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=RIZQ9D4TVeiIPcThtgzgGCiymqAbs470EacUiFaxTBk1jCuRz+VYjKN19dnumC72B9ZF9WwzBl4Xy/8l4xFHpbz4d6jKJ4QFq2kZSJ19ykoYVdMeGATvvyro85eIxz9OCYcr5L07eWYCz1W6+PET5ALtF5TEQgKcTpKTgt3+bX0=
Message-ID: <21d7e99705031115075e4378ed@mail.gmail.com>
Date: Sat, 12 Mar 2005 10:07:16 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: i830 DRM problems
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <422C5A25.3000701@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <422C5A25.3000701@ens-lyon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I am experiencing problems with DRM on my Dell Optiplex GX260.
> I am running a Debian Sarge with Vanilla Linux 2.6.11 and XFree 4.3.0.
> This one appeared while playing crack-attack and lead to a crash
> of the X server.
> 

a) does it work with 2.6.10?
b) does it work if you turn off intelfb?

Dave.
