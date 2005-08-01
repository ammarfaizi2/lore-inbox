Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVHAIIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVHAIIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVHAIIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:08:55 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:11346 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262045AbVHAIHb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:07:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GQzdVwJXOBq7hbDUVCbklbR8VrAsu/GgKIAiAWznqex1UKCNZf9W6MlX9z2QllfFvDstwSRGr1RtohRUWW5XDnkV8763GgWDf0RPUKhqxSdA14R4kQzX45qHimxCatftF4Z39colXVonl/KsBFfx0BTHE9tUAsn7fKhkRFy4f+I=
Message-ID: <25381867050801010710af48d6@mail.gmail.com>
Date: Mon, 1 Aug 2005 04:07:29 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: abonilla@linuxwireless.org
Subject: Re: IBM HDAPS, I need a tip.
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       hdaps devel <hdaps-devel@lists.sourceforge.net>,
       Dave Hansen <dave@sr71.net>, Jan Engelhardt <jengelh@linux01.gwdg.de>
In-Reply-To: <Pine.LNX.4.61.0508010844380.6353@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1122861215.11148.26.camel@localhost.localdomain>
	 <1122872189.5299.1.camel@localhost.localdomain>
	 <1122873057.15825.26.camel@mindpipe>
	 <Pine.LNX.4.61.0508010844380.6353@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well don't forget there is a bios 'calibration' routine that you will
see on start up (especially if you are on a moving vehicle/train).
What is this calibration used for, and does it provide calibration
information to the windows driver? Could we use it somehow to help
solve this problem?

Yani

On 8/1/05, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> >So in order to calibrate it you need a readily available source of
> >constant acceleration, preferably with a known value.
> >
> >Hint: -9.8 m/sec^2.
> 
> Drop it out of the window? :)
> 
> 
> 
> Jan Engelhardt
> --
>
