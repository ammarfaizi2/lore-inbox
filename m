Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWHDJTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWHDJTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWHDJTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:19:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2016 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751244AbWHDJTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:19:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lC1q+68sIwJ2u/akRNy4iEiwppYdI+MALdMiN4GOZ6mQHMKqwj4phYMZSHNBGNDn1Qbw6k93NY+kt5wzfkb1l3pu/lFU0ByEYeuE1/yv6i16EV8IFkWp09zKAzv+Vx3FAeK9y9BasRIGPe4dcQlCAbqVG/Gkn6QMICaDInA9BGA=
Message-ID: <9a8748490608040219q3c385440u3503bf6504f84d4a@mail.gmail.com>
Date: Fri, 4 Aug 2006 11:19:37 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Patrick McHardy" <kaber@trash.net>
Subject: Re: [patch 00/23] -stable review
Cc: "Greg KH" <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, "Justin Forbes" <jmforbes@linuxtx.org>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy Dunlap" <rdunlap@xenotime.net>,
       "Dave Jones" <davej@redhat.com>,
       "Chuck Wolber" <chuckw@quantumlinux.com>,
       "Chris Wedgwood" <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <44D30F04.9060300@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060804053807.GA769@kroah.com>
	 <9a8748490608040204o58f7f594qe8c3316fcdf00ea4@mail.gmail.com>
	 <44D30F04.9060300@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/06, Patrick McHardy <kaber@trash.net> wrote:
> Jesper Juhl wrote:
> > Any chance that the fixes in the (latest) e1000 driver version
> > 7.1.9-k4 will get backported?
> >
> > I get messages along the lines of "kernel: Virtual device XXX asks to
> > queue packet!" and the device then refuses to work.
> > The last kernel where I know for a fact that it worked OK is 2.6.11,
> > so that's what the server is currently running.
>
> That message should never be seen on a device with a queue. What device
> exactly is "XXX"?
>
eth0.20


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
