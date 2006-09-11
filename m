Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWIKWxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWIKWxz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWIKWxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:53:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:37076 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932277AbWIKWxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:53:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NUKq4ja6xmih+zhfk6WrD6pngHC45hk5VAX6i+/oZCqYSVWoh234sGFe40Ni+cbMnGLbo6G95IdQcJdTCmuZRlZ18ceGJV99BFrfyxGiDJOC3Ok0dyD2oqn7mUWFk2Pu/BMZRu2sS0u3o5dga+ZX+UM4DJEgJoqgnntA4NdBzEI=
Message-ID: <87f94c370609111553m102cc128tf30058e5fff9e887@mail.gmail.com>
Date: Mon, 11 Sep 2006 18:53:51 -0400
From: "Greg Freemyer" <greg.freemyer@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: What's in libata-dev.git
Cc: "Jens Axboe" <axboe@kernel.dk>, "Linus Torvalds" <torvalds@osdl.org>,
       "Jens Axboe" <axboe@suse.de>, "Jeff Garzik" <jeff@garzik.org>,
       "Sergei Shtylyov" <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1158015636.23085.218.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060911132250.GA5178@havoc.gtf.org> <450566A2.1090009@garzik.org>
	 <450568F3.3020005@ru.mvista.com>
	 <1157986974.23085.147.camel@localhost.localdomain>
	 <45057651.8000404@garzik.org>
	 <1157988513.23085.159.camel@localhost.localdomain>
	 <20060911153706.GE4955@suse.de>
	 <Pine.LNX.4.64.0609110850380.27779@g5.osdl.org>
	 <20060911195106.GA6775@kernel.dk>
	 <1158015636.23085.218.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-09-11 am 21:51 +0200, ysgrifennodd Jens Axboe:
> > Well, as I said, I don't think we ever saw a case that was demonstrably
> > due to the 256 sector issue. And I really don't think it is as obscure a
> > fact that people seem to think it is.
>
> One of the ones I've got saved here is this thread. Paul goes on to
> demonstrate that changing the 255<->256 limit makes 2.0/2.2/2.4 break or
> not break.
>
<snip>

The whole thread is at http://lkml.org/lkml/2001/3/18/29

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
