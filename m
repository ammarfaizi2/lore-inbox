Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVF1LNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVF1LNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVF1LNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:13:08 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:35638 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261282AbVF1LND convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:13:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TcCo1y/RhhSvekWcfpy4v4DzMIMPy6Tvw0cLQS0MMUmopRky0ftzqS09ztXp/bBI6oAtcVcW+GILMqdhbyaRUkXoPbp2pUvMv3d+9asX8fELMQmkwonNxZd61U3mW9dOHmkXWA9QWh5v2giMmZnObsspyipB0QJ+OMWzxunPp5s=
Message-ID: <98df96d3050628041362ea8d1b@mail.gmail.com>
Date: Tue, 28 Jun 2005 20:13:02 +0900
From: Hiro Yoshioka <lkml.hyoshiok@gmail.com>
Reply-To: hyoshiok@miraclelinux.com
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: i2o driver and OOM killer on 2.6.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98df96d305062506477e32f447@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <98df96d305062503281efa5f5a@mail.gmail.com>
	 <1119702614.3157.19.camel@laptopd505.fenrus.org>
	 <98df96d305062506477e32f447@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/05, Hiro Yoshioka <lkml.hyoshiok@gmail.com> wrote:
> Arjan,
> 
> On 6/25/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sat, 2005-06-25 at 19:28 +0900, Hiro Yoshioka wrote:
> > > Hi,
> > >
> > > I got the following OOM killer on 2.6.9 by iozone. The machine has a
> > > i2o driver so it may have issues.
> >
> >
> > 2.6.9 is a really really old kernel by now; you're probably much better
> > off using 2.6.12
> 
> Thanks for your help.
> 
> It is RHEL 2.6.9-5.EL based kernel. I'll try to reproduce 2.6.12 kernel.
> 
> Regards,
>   Hiro
> 

I tried to reproduce on 2.6.12.1 but I could not get OOM.

Thanks,
 Hiro
