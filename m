Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUHMN5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUHMN5M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 09:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUHMN5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 09:57:11 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:62559 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265314AbUHMN4W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 09:56:22 -0400
Message-ID: <2a4f155d0408130656697b908b@mail.gmail.com>
Date: Fri, 13 Aug 2004 16:56:21 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Two problems with 2.6.8-rc4-mm1
In-Reply-To: <1092398631.24408.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <2a4f155d0408130401112dad3a@mail.gmail.com> <1092398631.24408.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 13:03:52 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2004-08-13 at 12:01, ismail dönmez wrote:
> > Probing IDE interface ide2...
> > ide2: Wait for ready failed before probe !
> > Probing IDE interface ide3...
> > ide3: Wait for ready failed before probe !
> > Probing IDE interface ide4...
> > ide4: Wait for ready failed before probe !
> > Probing IDE interface ide5...
> > ide5: Wait for ready failed before probe !
> 
> This is debug stuff. In the latest ide patch I turned them to
> KERN_DEBUG.
> 

Good nothing to worry about then.

Cheers,
ismail



-- 
Time is what you make of it
