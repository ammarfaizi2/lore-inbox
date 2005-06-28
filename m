Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVF1MKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVF1MKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVF1MKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:10:25 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:7231 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261403AbVF1MKV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:10:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jkRczmaCK5P8RxorjjqAlH77nMs75q+j1SsrSCXf2JcB0ah/zk6WlsdRVgHubp+xri40Ef5oRq7UMv2qMqeudcjs6J4VfNjDgVZS6GBtXTUYjDmfc2jot5Vqb67paPLG6+36E3xEcDidiBShNtF1QnR+kkF7YVM4hdMCzvEJHNU=
Message-ID: <3afbacad050628051059b69bbe@mail.gmail.com>
Date: Tue, 28 Jun 2005 14:10:18 +0200
From: Jim MacBaine <jmacbaine@gmail.com>
Reply-To: Jim MacBaine <jmacbaine@gmail.com>
To: stable@kernel.org
Subject: Re: [00/07] -stable review
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050627224651.GI9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050627224651.GI9046@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/05, Chris Wright <chrisw@osdl.org> wrote:

> Responses should be made by Wed, Jun 29, 23:00 UTC.  Anything received after
> that time, might be too late.

Will the fix for the iptables physdev match go into -stable?

I'd regard the aesthetic objections as secondary in a stable kernel
series.  If physdev match stays in the kernel, the fix should IMHO go
into -stable.

Regards,
Jim
