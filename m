Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbVKRUlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbVKRUlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbVKRUlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:41:16 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:3807 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161183AbVKRUlP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:41:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZkDl2j1H482DyH3M6lEG8gV3lEo92n7hZ2sGXiSYopUyurg+y6wii22KX9xfG66qDSQOtTu2sEOqeNAYB6Ag0/n6k3URaeT1jG/M9Jm3fA39s5Pkps/8FAAfxQDppNe9cfdqV4RKnFCOqreh2LDZlGLC8LdtnzzefbcGlO9ZVaE=
Message-ID: <58cb370e0511181241r62d5248amb0cf4215ccdb6793@mail.gmail.com>
Date: Fri, 18 Nov 2005 21:41:14 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers (v2)
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
In-Reply-To: <436B3D74.3080807@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43146CC3.4010005@gentoo.org>
	 <58cb370e05083008121f2eb783@mail.gmail.com>
	 <43179CC9.8090608@gentoo.org>
	 <58cb370e050927062049be32f8@mail.gmail.com>
	 <433B179A.8010600@gentoo.org> <436B3D74.3080807@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Daniel Drake <dsd@gentoo.org> wrote:
> Daniel Drake wrote:
> > Support multiple controllers in the via82cxxx IDE driver, revised patch.
> > Cable detection and ISA bridge finding have been moved into their own
> > functions.
> >
> > Unfortunately I won't have access to a via82cxxx machine until December
> > now, this patch is only compile-tested.
>
> I went home a little earlier than expected and tested this patch on my
> single-controller via machine. It works fine. Is this ok to be merged?

applied
