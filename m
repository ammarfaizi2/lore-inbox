Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWIYLmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWIYLmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWIYLmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:42:14 -0400
Received: from hu-out-0506.google.com ([72.14.214.239]:25480 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751414AbWIYLmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:42:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iuykA7ukhR32fC2c30gJsM3bjat3onAPuPTs6kmXG4npB9BsnQIxQmeJXOejW9O4506AKk4Ligbcq4uxObYaHCSA7YFUQk8PZk8IdPL4CMQ0TwovLEgg4D3u9ZUvNONKmHbinxifpobgfSDp7fPDy1IDCFcYyu20WbbjQRr86Jw=
Message-ID: <ce55079f0609250442x5638a93fuac95c65a54a0927@mail.gmail.com>
Date: Mon, 25 Sep 2006 15:42:12 +0400
From: Vladimir <vovan888@gmail.com>
To: lamikr@cc.jyu.fi
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa driver.
Cc: tony@atomide.com, OMAP-Linux <linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44FF2A6D.3000500@cc.jyu.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44E51565.6020505@cc.jyu.fi> <20060905151808.GC18073@atomide.com>
	 <44FF2A6D.3000500@cc.jyu.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) As we do not yet have any kind of multiplexing support to gsm module
> (currently directly accesing dev/ttyS1 for at commands)
> our phone app is not able to run simultaneously with the ppp. I am not
> sure should I resolve this in the kernel space or user space.
>

I work on getting linux running on Siemens SX1 mobile phone.
and I use GSM multiplexer daemon from here -
http://developer.berlios.de/projects/gsmmux/
it works fine for me.
