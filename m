Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVJ0ELi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVJ0ELi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 00:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVJ0ELi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 00:11:38 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:33502 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964961AbVJ0ELi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 00:11:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OkWWZ3ZUExzh4U74F6oVWEhJ7s9q18yLr7Ns+g9G07ROgjStoXciQyGW/Yd6xEbsR2VOu8yoIQVpv5jDnMjG6tPUoDG+ZT+wySJiKfNKAkGhhBFe0yKKelWUOEaUTLDxKqjUX+Ji/Tw2hNJAL6cwlOVQwbMIWuClxZ9DGzv8MwE=
Message-ID: <82b32ed40510262111m2e3b749yca4f78982e879e5e@mail.gmail.com>
Date: Wed, 26 Oct 2005 21:11:37 -0700
From: Badari Pulavarty <pbadari@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH] Fwd: 2.6.14-rc5 GPF in radeon_cp_init_ring_buffer() (fwd)
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510261103510.24177@skynet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0510261103510.24177@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Dave Airlie <airlied@linux.ie> wrote:
>
> Hi Linus/Andrew,
>
> Another 2.6.14 DRM fix.. they always come in 3s.. hopefully thats it..
>
> Dave.
>

Seems to have fixed my problem.

Thanks,
Badari
