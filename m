Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVLKWNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVLKWNB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 17:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVLKWNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 17:13:01 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:32041 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750886AbVLKWNB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 17:13:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iW3C6ByoTbpo4VkSc2EqM/yNbNk1yskOl9vDpMQDvTCHZHrfs3OlGSsQjndNZfecrYCJM3+eAMHft7wenbTIYFL4NOXn/BwvzrhhRf9QJ1ezIhBj1pM0mWvcVZ6ZlPr4IASY5Ni+WkwWdclJ74o/KXZDkVTF0rR6FWiQ5SEBymg=
Message-ID: <625fc13d0512111413jfa3f340u17c910aadc11b41@mail.gmail.com>
Date: Sun, 11 Dec 2005 16:13:00 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] remove fs/jffs2/ioctl.c
Cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org, jffs-dev@axis.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051211180702.GO23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051211180702.GO23349@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/05, Adrian Bunk <bunk@stusta.de> wrote:
> There doesn't seem to be any reason for keeping fs/jffs2/ioctl.c .
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
>
> This patch was already sent on:
> - 1 Nov 2005

With ACKs by a couple people on the list whose opinion doesn't quite
carry as much weight as David's.

josh
