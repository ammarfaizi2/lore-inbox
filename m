Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVHRMlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVHRMlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 08:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVHRMlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 08:41:12 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:6478 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932199AbVHRMlL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 08:41:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fqxgbyQZL+2dtG3rTvqq0KtjNRBX4igbVWgFdsJsTn086Gd/NGVNOOZ0xRm45TNJy60/Ef3+aZrsKf8oBV9eK/PHYym6gjc/a3zoEMUg8FvrU8o2x0V+W+uZbTv+TUcC+tAScF95BvgNgNgvqQG4IYlyXllITzyfaj/OwN8qMfE=
Message-ID: <398d693005081805415a8a316a@mail.gmail.com>
Date: Thu, 18 Aug 2005 20:41:07 +0800
From: Xuekun Hu <xuekun.hu@gmail.com>
To: Ray Bryant <raybry@mpdtxmail.amd.com>
Subject: Re: lockmeter: fix lock counter roll over issue
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hawkes@sgi.com
In-Reply-To: <200508150916.54276.raybry@mpdtxmail.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <398d69300508132100327e3712@mail.gmail.com>
	 <398d69300508150035246230af@mail.gmail.com>
	 <200508150916.54276.raybry@mpdtxmail.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ray

Did you test the patch? Any updates?
I have tested the patch and no errors were found. 

Thx, Xuekun 

On 8/15/05, Ray Bryant <raybry@mpdtxmail.amd.com> wrote:
> On Monday 15 August 2005 02:35, Xuekun Hu wrote:
> > Does anyone have inputs?
> >
> 
> Xuekun ,
> 
> I was on vacation last week.   I just saw your patch yesterday.  It looks
> reasonable, but I will test it later today.
> 
> You should also cc John Hawkes (hawkes@sgi.com).
> 
> Also, please note my email address change:  my current email address is
> raybry@mpdtxmail.amd.com.
> 
> Andrew is not so much interested in these changes as the lockmeter patch is
> not in -mm.
> --
> Ray Bryant
> AMD Performance Labs                   Austin, Tx
> 512-602-0038 (o)                 512-507-7807 (c)
> 
>
