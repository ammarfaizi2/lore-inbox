Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVJFQhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVJFQhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 12:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVJFQhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 12:37:09 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:19816 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750839AbVJFQhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 12:37:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=gXjLXei3qDjhDYXrfIOMBlDTu8BcSvo0BNMtvDnrGKo09OtA9D2IIMEgwTBOjJMUyutxXVF0DGM9+Dy2YudkbbcRfeAH56aKVpbEtPDl0HPWE24IPgt6bpW0ZC9roPnNfl5THtOnu9bOEqAwc7mOFTHfj2nkEGr5sd+yliqsq3Y=
Date: Thu, 6 Oct 2005 20:48:30 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ksymoops should no longer be used to decode Oops messages
Message-ID: <20051006164830.GA22974@mipter.zuzino.mipt.ru>
References: <200510052239.43492.jesper.juhl@gmail.com> <di3h5d$f82$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <di3h5d$f82$1@sea.gmane.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 12:49:48AM +0900, Kalin KOZHUHAROV wrote:
> > Ksymoops
> > --------
> >
> >-If the unthinkable happens and your kernel oopses, you'll need a 2.4
> >-version of ksymoops to decode the report; see REPORTING-BUGS in the
> >-root of the Linux source for more information.
> >+With a 2.4 kernel you need ksymoops to decode a kernel Oops message. With
> >+2.6 kernels ksymoops is no longer needed and should not be used.

> OK, but what should I use then with 2.6??

Raw Oops output. From logs, serial console, monitor photoed with
digital camera, copied to paper with pencil...

