Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVIMJbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVIMJbB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbVIMJbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:31:01 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:54007 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932464AbVIMJbA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:31:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XM+WhMKwXY3LVi0F4fZ8U9jZI7wqMQaGjpTrjUwgNucP+1WFAUvY9DqjnWNskAEr9itLPxczVEQBULql3XMy9qTW6Af/Ef5o4aYG+6tkE3Re1pgufJS9F+PvmDJ0hlZuPB4AXYLvrO2Kn7m6Q/dKrAQc2A+m2H+0OtOc75danWQ=
Message-ID: <1e33f571050913023042b4c109@mail.gmail.com>
Date: Tue, 13 Sep 2005 15:00:59 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
Reply-To: gaurav4lkg@gmail.com
To: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: Re: how to use wait_event_interruptible_timeout
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050913092048.13490.qmail@web8503.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050913092048.13490.qmail@web8503.mail.in.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/05, manomugdha biswas <manomugdhab@yahoo.co.in> wrote:
> Hi,
> I was using interruptible_sleep_on_timeout() in kernel
> 2.4. In kernel 2.6 I have use
> wait_event_interruptible_timeout. But it is now
> working!!. interruptible_sleep_on_timeout() was
> working fine. Could anyone please help me in this
> regard.

What problem are you facing with wait_event_interruptible_timeout() in 2.6
Elaborate more on it.

-Gaurav

> Regards,
> Mano
> 
> Manomugdha Biswas
> 
> 
> 
> __________________________________________________________
> Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
- Gaurav
my blog: http://lkdp.blogspot.com/
--
