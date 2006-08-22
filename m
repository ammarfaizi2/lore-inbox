Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWHVAN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWHVAN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWHVAN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:13:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:23454 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750850AbWHVAN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:13:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cIWeIQA4N5IQP8lthOoxg4S5WpZR/ULomDXu0JQ8m3AzUYaE6dszaav7JtEv8+jVanKpfgxaOPdqFq+oSeOQNixtjIzxOnRFFSjPJ1Gn17lG5OIOSpSnHldj2IAN4mkSoOG/Ctr8I5MsGPd983f+td2T53PXFHrhnU5EmRB9Bnw=
Message-ID: <21d7e9970608211713m7e554884l3a0e93b9ed4274f0@mail.gmail.com>
Date: Tue, 22 Aug 2006 10:13:56 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH] intelfbhw.c: intelfbhw_get_p1p2 defined but not used
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Sylvain Meyer" <sylvain.meyer@worldonline.fr>,
       "Parag Warudkar" <kernel-stuff@comcast.net>,
       linux-kernel@vger.kernel.org, "Antonino Daplas" <adaplas@pol.net>
In-Reply-To: <20060730125033.efb0d87e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0607060154130.2027@gentoo.warudkars.net>
	 <20060730125033.efb0d87e.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Patch against 2.6.18-rc1.
>
> Can we please have this patch merged in Linus' tree now?
>

I've put this in my intelfb tree....

Dave.
