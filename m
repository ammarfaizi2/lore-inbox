Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVJFKGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVJFKGz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVJFKGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:06:55 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:42354 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbVJFKGy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:06:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MuGicI3MjCi/bYN6HUD8NBJDJFYBH1s1FBSRIwcFjQNCgD/NBo0cWEkqDMS/Msb1mx/zmUnzmJfi+yZEg67Jo/I9BE8X9CSj4cKD8FAT4hvOjtGuh0EFgNdXnWb7JF9jETvLeUinGH30ojRmA5Fbp1FzeZgF3l9PcdXvWnc4oho=
Message-ID: <2cd57c900510060306p1fd8075cm6a8c7428194af461@mail.gmail.com>
Date: Thu, 6 Oct 2005 18:06:52 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Ustyugov Roman <dr_unique@ymg.ru>
Subject: Re: [Question]: system register cr3
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200510060941.25535.dr_unique@ymg.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510060941.25535.dr_unique@ymg.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Ustyugov Roman <dr_unique@ymg.ru> wrote:
>
> > Hi!
> > I change value of cr3 register.
> > After that TLB cache flushed. Does it also flush instruction cache in processor?

No.

>
> Arch is i386.

cr3 is a i386 thing.

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
