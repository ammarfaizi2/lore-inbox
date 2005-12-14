Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVLNDCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVLNDCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVLNDCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:02:32 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:46525 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030202AbVLNDCb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:02:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nKIpXEcdn3dxAKUDKWSHbZAXqunN02GlrS2xvqvExX6veAOh5wjXuo8mUqSxGkytRO9qHshUzi2MwUe7QARs+W/SzmeSfXzygl9jkT1MxJbhPV1/IHfC0i6Z8e8Pd0yzqMaC/f0f+ZRKZ7Pjc0XB4y3pnRd0GeTXpiyst6UqnHw=
Message-ID: <2cd57c900512131902i2ff9ba1ak@mail.gmail.com>
Date: Wed, 14 Dec 2005 11:02:29 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: bugs?
Cc: Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200512132114.23496.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <439F79CE.6040609@ens.etsmtl.ca>
	 <200512132114.23496.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/14, Dmitry Torokhov <dtor_core@ameritech.net>:
> On Tuesday 13 December 2005 20:47, Caroline GAUDREAU wrote:
> > my cpu is 1400MHz, but why there's cpu MHz         : 598.593
> >
>
> Do you have cpufreq active?

Caro, do a "$ grep -i cpufreq /boot/config".

>
> [root@core ~]# cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 11
> model name      : Intel(R) Pentium(R) III Mobile CPU      1000MHz
> stepping        : 1
> cpu MHz         : 730.646
>
> --
> Dmitry
>


--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
