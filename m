Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVI2X0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVI2X0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVI2X0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:26:41 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:58151 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751362AbVI2X0k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:26:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WKjHXXMeNTs/eYYBNv5ub1A7/hxTEKteGQcRssxAdRlfyN3wEAqT7QtcJX/a6Ktk1g8YTAHJqBe0dXiyioAUsf7d9HMaahD2KT6B9TxDVT6c06VJdB6wvyteFGB5xiRnOUGww5si1OuWJQHP31bsvoTBpj9dRnSfvHbhWVWRsNk=
Message-ID: <5bdc1c8b050929162689415dd@mail.gmail.com>
Date: Thu, 29 Sep 2005 16:26:38 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc2-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050929143732.59d22569.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/05, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
>
> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
>

Hi,
   I'm semi-sure at this point that the xrun problems I'm seeing on my
AMD64/NForce4 machine (Asus A8N-E motherboard) are isolated to the
SATA drive. Is there anything here that might address that? I'm
currently running 2.6.14-rc2-mm1. I've got this machine headless at
the moment. I can move data reliably using the CDRW drive, the DVD
drive with xine, and I can copy lots of data off and on my 1394
drives. I can run Ardour, Aqualung and lots of other apps remotely
using this machine as a server. When I start using the SATA drive,
read or write, I get lots xruns.

- Mark
