Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVIQKZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVIQKZv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbVIQKZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:25:51 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:36649 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751035AbVIQKZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:25:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=A3ryG+Vo57uWBKcSmJgTT4Khn19SMCyk8JncMuJ3bWuKRFuOc7CzmLHQtLDXfzDL9/zKjPmLfCd5wDgqgNP5Zjkq3fWZHnI+EhpLQVUJW+LrCJmnKgE/GNNhSOMPm/4AVEIGqS3hRcdgZXucaXd79aO7SNQfuEhVBrOvRNOFuuY=
Date: Sat, 17 Sep 2005 14:36:14 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: snd-usb-audio modpost warnings
Message-ID: <20050917103614.GA6956@mipter.zuzino.mipt.ru>
References: <Pine.SOC.4.61.0509161002560.22187@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0509161002560.22187@math.ut.ee>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 10:04:51AM +0300, Meelis Roos wrote:
> FYI: todays git snapshot gives these warnings:

-git3?

>   MODPOST
> *** Warning: "__compound_literal.200" [sound/usb/snd-usb-audio.ko] 
> undefined!

Please, send .config

