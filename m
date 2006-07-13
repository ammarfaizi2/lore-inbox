Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWGMAZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWGMAZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 20:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWGMAZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 20:25:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:14093 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750754AbWGMAZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 20:25:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rkgN6g5NUviQSNHa8VK8ksDJhWrkI1kQxbD9XKuULspFOvbTH2U689pkZ3vSMH8Vl5qy192tRqHEC8KIfVJ4Z3EyH7J6jX4bdhvMnzj1SkoiuieDSwgHNSZbmfD/6wmBoZ1cuu135N+mee+rfoQic9ywt7oCmuDHExqI/9tvgGA=
Message-ID: <29495f1d0607121725te495c25n3322646717f8c4a@mail.gmail.com>
Date: Wed, 12 Jul 2006 17:25:29 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH 3/3] [PATCH] w1: remove drivers/w1/w1.h
Cc: linux-kernel@vger.kernel.org, "Adrian Bunk" <bunk@stusta.de>,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Greg Kroah-Hartman" <gregkh@suse.de>
In-Reply-To: <1152746704578-git-send-email-greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060712232249.GA22654@kroah.com>
	 <11527466963731-git-send-email-greg@kroah.com>
	 <11527467003943-git-send-email-greg@kroah.com>
	 <1152746704578-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/06, Greg KH <greg@kroah.com> wrote:
> From: Adrian Bunk <bunk@stusta.de>
>
> drivers/w1/w1_io.h is both a subset of drivers/w1/w1.h and no longer
> #include'd by any file.
>
> This patch therefore removes w1_io.h.

Minor nit, that's not what the subject says.

Thanks,
Nish
