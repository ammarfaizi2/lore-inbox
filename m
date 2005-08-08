Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVHHEeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVHHEeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 00:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVHHEeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 00:34:37 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:33512 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750720AbVHHEeg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 00:34:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ANBDhzXHHkJ6xmDUYFxO7xJnRdYKn8Ns1FajjrHprdCeSQlvhygT+0xSLV6nCxcyq8yL19dSt7cKisVCYUaK//vdPT1cMt39LKobrQt8GIcVb0f6K3SV+nk2/ss+51wl3QlGpWQW7ydc68oBT0q8xuIKtUDfflX7AMAZEXe9dbA=
Message-ID: <29495f1d05080721346c17d299@mail.gmail.com>
Date: Sun, 7 Aug 2005 21:34:36 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Fawad Lateef <fawadlateef@gmail.com>
Subject: Re: Highmemory Problem with RHEL3 .... 2.4.21-5.ELsmp
Cc: linux-kernel@vger.kernel.org, nhorman@redhat.com
In-Reply-To: <1e62d137050807205047daf9e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1e62d137050807205047daf9e0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/05, Fawad Lateef <fawadlateef@gmail.com> wrote:
> Hello,
> 
> I m facing a problem in RHEL3 (2.4.21-5.ELsmp) kernel while using
> kmap_atomic on the pages reserved at the boot time !!!!

Unless you can reproduce this in a current kernel.org kernel
(2.6.13-rc6), then you probably should contact RedHat for support.

Thanks,
Nish
