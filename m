Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVH3HNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVH3HNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 03:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVH3HNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 03:13:24 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:55909 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751154AbVH3HNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 03:13:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=nUCGw0IvbQRJvmt7toJcwClGfJRuHHSCdxodj7wJDBdp2x/HLPM1Kp8dWVJspYQtb95u4L/zah2G1LMfh15cz0B/dQSTwf3xS3yhcFkHiRjUi1WlmM8shtl5AVhJ/PsmLOyAap0FeKqrG2dOcCtl/ytv7V/UAmWZnLlWcH5EG1Y=
Date: Tue, 30 Aug 2005 11:22:48 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/s2io.h - lvalue fix
Message-ID: <20050830072248.GA12449@mipter.zuzino.mipt.ru>
References: <20050829222417.GA20292@localhost.localdomain> <9a874849050829154311bd433d@mail.gmail.com> <20050829230725.GA2736@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050829230725.GA2736@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 01:07:25AM +0200, Stephane Wirtel wrote:
> > Hmm, neither do I. Looking in MAINTAINERS I don't see anybody, and
> > looking in the sources I find just a company name `Neterion'.
> > So, lacking an email address for a maintainer, sending your patch to
> > linux-kernel is the right thing to do (even if you had found a
> > maintainer, adding linux-kernel to Cc: would usually also be proper).
> > If you get no response at all from the list or maintainer, then Andrew
> > Morton is the head 2.6 maintainer.
> Ok, thanks for your response.

s2io is a network driver, so Cc'ing netdev@ should be enough.

