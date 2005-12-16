Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVLPHzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVLPHzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 02:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVLPHzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 02:55:17 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:42370 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932169AbVLPHzP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 02:55:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ThB0Ka9eFH22X/ad5VEcigoiRwdtK/xti2ugkWWAdTV9lIz+01mPQb5SgZZ4kSHSOP0t3QfqxEsywMoGbBMs6RE/laCE78molVc9CHIK72b+jbZsKdGvl7sjuAKO8rdjR3gNN2xDMPbbTHTvyIDpnqxiaAq1IhbAsZhjOTpf/uI=
Message-ID: <84144f020512152355p1d0934bdqe74fbe898c236982@mail.gmail.com>
Date: Fri, 16 Dec 2005 09:55:13 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Puneet Vyas <puneetvyas@gmail.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Cc: Ismail Donmez <ismail@uludag.org.tr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43A239B4.8010309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051211180536.GM23349@stusta.de>
	 <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr>
	 <200512160112.30179.ismail@uludag.org.tr> <43A239B4.8010309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/16/05, Puneet Vyas <puneetvyas@gmail.com> wrote:
> If the learned folks here think that "ndiswrapper" is some user space
> program that people can live without than at least
> 3 people in my house are doomed. We like to use linux but do not have
> luxury that Ismail enjoys. At least windows
> does not make such decisions on my behalf. Sigh.

While I understand that you're frustrated, please direct it towards
your vendor who is unwilling to open up the hardware documentation.
The binary-only drivers you are using are not supported on Linux (you
took them from Windows, remember) and the only way you're ever going
to get reliable wireless support is by reverse engineering or vendor
opening up the specs.

                                Pekka
