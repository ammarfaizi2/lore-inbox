Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752206AbWAEUNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbWAEUNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbWAEUNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:13:40 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:53616 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752206AbWAEUNj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:13:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IrjBMw6nVoLfNquK65XTDNMfC6/7jOyIUIdik2lmeAh7f0MO9DfSYhaN74kkUdj+0yoUduMofBcbW9KvOUojNjrul8SrwKvMat9VAb4uK8+hP2uKw1R2S7xjS65CRkO3TJNxhpLc4yiTzm4LBfLAp1S4ldZt7epNn3gOB2ljeFc=
Message-ID: <df33fe7c0601051213v70732efw@mail.gmail.com>
Date: Thu, 5 Jan 2006 21:13:37 +0100
From: Takis <panagiotis.issaris@gmail.com>
Reply-To: takis@issaris.org
To: mkrufky@m1k.net
Subject: Re: [PATCH] drivers/media: Conversions from kmalloc+memset to k(z|c)alloc.
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Johannes Stezenbach <js@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <43BD4CB7.4030008@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105130229.7E65F6B35@localhost.localdomain>
	 <43BD4CB7.4030008@m1k.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/5, Michael Krufky <mkrufky@m1k.net>:
> ...
> It is very wrong of you to assume that every subsystem maintainer is
> current on LKML...  In the future, please cc Linux and Kernel Video
> <video4linux-list@redhat.com> and / or Mauro Carvalho Chehab
> <mchehab@infradead.org> + Johannes Stezenbach <js@linuxtv.org>
> (official v4l / dvb subsystem maintainers)  with all patches to v4l /
> dvb subsystems.
>
> This information IS in the MAINTAINERS file.
Sorry. Will do next time.

With friendly regards,
Takis
