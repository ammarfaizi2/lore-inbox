Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVIUOzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVIUOzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVIUOzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:55:40 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:47038 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751039AbVIUOzj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:55:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rKb8x/SOjdw0zbS7HnzPtkDLnb8EYfahyVx9xSXZ1T3VJD2lvXzWuK9N6Ks95+Ia8ZnIqpUhmu2fpB2KlBrFuHqR3FY4XNvYJRhEMjcUC/KY6MHFPzw+bzLSq8nCYBd+Xfi37tW6JVPCVL0z+g0e6KLi2OOSpAKfrtBUtYupOp0=
Message-ID: <40f323d0050921075536c6b160@mail.gmail.com>
Date: Wed, 21 Sep 2005 16:55:38 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: bboissin@gmail.com
To: Mateusz Berezecki <mateuszb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ipw2200 using old wireless extensions
In-Reply-To: <20050921115600.GB8129@pc2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4329E09B.9020807@drzeus.cx> <432F0BC6.3040100@tmr.com>
	 <432F1280.3040209@pobox.com> <20050921115600.GB8129@pc2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/05, Mateusz Berezecki <mateuszb@gmail.com> wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> | Bill Davidsen wrote:
> | >Pierre Ossman wrote:
> | >
> | >>With the inclusion of the ipw2200 driver and the update of the wireless
> | >>extensions I get my dmesg flooded with these:
> | >>
> | >>eth0 (WE) : Driver using old /proc/net/wireless support, please fix
> | >>driver !
> | >>
> | >>Somebody please make the hurting go away :)
> 
>   Where should I take a look for new WE code ? and hints on how to use
>   it? :-P
> 
> 
There are patches for upstream that were posted on the ipw2100-devel
mailing list.

regards,

Benoit
