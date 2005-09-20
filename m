Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVITM17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVITM17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVITM17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:27:59 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:38879 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964987AbVITM16 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:27:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eJ5zNGavZCn1VaARv7J54ZJaltPt26+XW1m06wGn+cuoVSyAkHi5H3xsgP8np8UzOoucYFfBTg5I8oMe3YtvU5/GRYdY70M1NwQyqIVCCR9xjAf/bOkH70BlvkVmGeVtMjtwlbl/O7z2SBwk2ugHcP/2jlVBfhcSrXFwn2bksfg=
Message-ID: <9a87484905092005277f1bb470@mail.gmail.com>
Date: Tue, 20 Sep 2005 14:27:54 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: fawadlateef@gmail.com
Subject: Re: regarding kernel compilation
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       Gireesh Kumar <gireesh.kumar@einfochips.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1e62d137050920013752bf31d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <32854.192.168.9.246.1127197320.squirrel@192.168.9.246>
	 <1e62d13705092000112a49cb6c@mail.gmail.com>
	 <200509201112.28091.vda@ilport.com.ua>
	 <1e62d137050920013752bf31d7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Fawad Lateef <fawadlateef@gmail.com> wrote:
> On 9/20/05, Denis Vlasenko <vda@ilport.com.ua> wrote:
> > On Tuesday 20 September 2005 10:11, Fawad Lateef wrote:
> > > I don't think you will be able to compile 2.4 kernel on to the 2.6
> > > kernel based distro .... as in 2.6 based distro, mod-utils and other
> >
> > 2.6 modutils (module-init-tools to be exact) fall back to <toolname>.old
> > (by just exec'ing it) if those exist.
> >
> 
> you are right, but if they exists .... but what IIRC I havn't found
> them on FC4/RH EL4 distributions .....
> 
Slackware 10.0, 10.1 and 10.2 run just fine with 2.4.x and 2.6.x
kernels and you can build, install and run both just fine - no
problems at all there (even Slackware 9.1 will work with a few small
changes).

> > > packages are updated and will only support 2.6 based kernel .... So
> >
> > Not true. I compiled 2.4 kernels on 2.6 machine without any problems.
> >
> On which distribution 2.6 based you compiled and succesfully run 2.4
> kernel ??? b/c its not working on FC3/FC4/AS4 .........
> 
Those are just a small subset of available distributions. Just because
it won't work there doesn't mean much.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
