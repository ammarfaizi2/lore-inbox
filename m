Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVK0Bvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVK0Bvi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 20:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVK0Bvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 20:51:38 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:22213 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750802AbVK0Bvh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 20:51:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pqawZX+109v58TVji16WUnU5d/pdJA6DCAhrQraCxjmAB7TFlrsfDNKwae7iXe/IqkuyJxeJypadIZwHnBonOxAhQJp97YM5AA/zacBjJ2bMbKrwSwDc8eTMggAU/gAVJFPCjbHIoBMK7kRpp+epr9YBgcbVqjNF0apKg4pUdug=
Message-ID: <9c21eeae0511261751p6741ad4fgd3f3d762e4c377f6@mail.gmail.com>
Date: Sat, 26 Nov 2005 17:51:34 -0800
From: David Brown <dmlb2000@gmail.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <200511262346.27907.s0348365@sms.ed.ac.uk>
	 <9c21eeae0511261713vacf13f5u5fdf19711635a381@mail.gmail.com>
	 <200511270138.25769.s0348365@sms.ed.ac.uk>
	 <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe you are untarring as non-root and David is untarring as root?

Yeah you can't very well compile and install a kernel without
permissions to /boot ;)

- David Brown
