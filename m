Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWAYX42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWAYX42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWAYX42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:56:28 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:38348 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751245AbWAYX41 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:56:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mFil2MdOF7u4WtwVDmX6cc/JFHbmbYh4IebEnPEZ/wxy9/hoWJ/21XwninfKxuMBNjGFlcNaIL1hrSwcAHfFIeti6sJTi3gUH1Y6SKi7d/GJ6PP34HB+w6jauvpBWHQgB2+uksX+8sB+vQBn0TOV3sV2hUWOtAZ5P6x3DrRfPYw=
Message-ID: <9a8748490601251556w2167fb39n34e768fc8716d41@mail.gmail.com>
Date: Thu, 26 Jan 2006 00:56:09 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "balamurugan@sahasrasolutions.com" <balamurugan@sahasrasolutions.com>
Subject: Re: problem i am facing
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <62018.203.101.38.164.1138191333.squirrel@66.98.166.28>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <62018.203.101.38.164.1138191333.squirrel@66.98.166.28>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, balamurugan@sahasrasolutions.com
<balamurugan@sahasrasolutions.com> wrote:
> hi all,
>
> i am booting the kernel 2.4.32 image in my hardisk, some probel is arise
>
> init:cannot execute "etc/rc/rc.sysinit
> init:Entering runlevel:1
> init:cannot execute "etc/rc.d/rc"
> init:no more process left in this level
>
>

How is this a kernel problem?

The kernel has launched init. init has problems running
etc/rc/rc.sysinit - how is this the kernels problem?
  - this is the linux-kernel development mailing list after all, not a
"random distro support list"...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
