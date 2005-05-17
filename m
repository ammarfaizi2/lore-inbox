Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVEQLZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVEQLZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVEQLYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:24:38 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:53600 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261371AbVEQLSy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 07:18:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H/wT+VaNC/cy/QJ87Cv0q4Kf1wqR+YqYxkg534LHgaVfUIgSSMKmVW03DAJyXm3k2zgOEN3467aP1V4GUJSszs1vPFw7+GoOIU6hLLrSPyVUfIUX9UVEPDwcHdiNOl+NgVOJeB5yt23rFBEWPJ9GuBL/C//E2RTC77EufVJ36sA=
Message-ID: <2538186705051704181a70dbbf@mail.gmail.com>
Date: Tue, 17 May 2005 07:18:51 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
In-Reply-To: <e9iUj0EZ.1116327879.1515720.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051703479bd0c29@mail.gmail.com>
	 <e9iUj0EZ.1116327879.1515720.khali@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 5/17/05, Jean Delvare <khali@linux-fr.org> wrote:
> If you could come up with an additional demonstration patch for either
> the lm90 driver or the it87 driver, I would happily give it a try. The
> adm1026 has very few users AFAIK so it might not be the best choice to
> find testers, although I agree that it was a convenient way to
> demonstrate how drivers could benefit from the proposed change.

No problem, I'll give this a shot later today/tomorrow when I get some
time, it shouldn't be very hard.

> 
> And, once again, thanks *a lot* for looking into this, this is very much
> appreciated.
> 

The concept benefits bmcsensors more than anything else so it isn't
exactly unselfish but thanks :-), its great to know its appreciated.

Yani
