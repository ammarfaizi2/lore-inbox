Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVHCVxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVHCVxG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVHCVxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:53:06 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:23469 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261563AbVHCVxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:53:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AxqJMSHwYksTPGyHuNrxjCptUm7OUZYL3gtT9IasCbDAoYXhyBLBwrGnzp5aXP8F1jvgkWz2lxH34zBIqCikorEoB1h5t0uub8k+0D79DI4FGwCXIlhCBQlDJuj1RifgVwbaYWOhVtM42o8zOvTH2emwR5AxHFBcYppven4+Eb4=
From: Andrew James Wade <andrew.j.wade@gmail.com>
Reply-To: andrew.j.wade@gmail.com
To: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Testing RC kernels [KORG]
Date: Wed, 3 Aug 2005 17:52:59 -0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, webmaster@kernel.org
References: <1123007589.24010.41.camel@jy.metro1.com> <20050802191303.09e635c3.rdunlap@xenotime.net> <200508022330.51364.gene.heskett@verizon.net>
In-Reply-To: <200508022330.51364.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508031753.00402.andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 2, 2005 11:30 pm, Gene Heskett wrote:
> And my point is that anyone with the skills to build a kernel 
> shouldn't have any problems at all find it with gftp.

I updated my kernel more frequently after learning of ketchup.
(<http://www.selenic.com/ketchup/>). The bother of getting the
patch sequence right and applying it was enough to discourage me.
No, it's not particularly difficult, but it may well be enough
to discourage casual testers. 

Posting a link to ketchup on kernel.org may also decrease the
bandwidth demand, as it seems to be pretty intelligent about
using patches.
