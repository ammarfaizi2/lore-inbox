Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVKZWid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVKZWid (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 17:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVKZWid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 17:38:33 -0500
Received: from hornet.berlios.de ([195.37.77.140]:51309 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S1750766AbVKZWic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 17:38:32 -0500
From: Michael Frank <mhf@users.berlios.de>
Reply-To: mhf@users.berlios.de
To: David Brown <dmlb2000@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Date: Sat, 26 Nov 2005 23:36:46 +0100
Cc: linux-kernel@vger.kernel.org
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <200511262319.15042.norbert-kernel@hipersonik.com> <9c21eeae0511261427ld8375bfi1c838b56cab426fb@mail.gmail.com>
In-Reply-To: <9c21eeae0511261427ld8375bfi1c838b56cab426fb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
Message-Id: <20051126223921.E7EF31AC3@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
On Saturday 26 November 2005 23:27, David Brown wrote:
> > The rights on the files should be sufficient for the
> > compiler to go through the tree and compile the kernel
> > for you. If it bothers you, you can just run chmod -R
> > to correct it.
>
> Yeah but it took me a couple of weeks and a few updates
> of my kernel to find it...
> Some one could have broke in and changed things without
> being root and I wouldn't have noticed it.
>
> > I guess that it will not be corrected.
>
> I just find it odd that I now have to check permissions
> all over the place to make sure everything is safe.
>

Check your umask and set it to 022 ;)
