Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932779AbWJGTRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbWJGTRw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932780AbWJGTRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:17:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:57862 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932779AbWJGTRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:17:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LeyFmVJuIp9Fd1fU2aXyLqMLeyFdYPH1LmoSkm4+IaOiQMTZToD5jyOizALopqHj8dkM8yjKOuKWoV7V1GSUuXvt8w8Rz8RQPH8StigwQL6kNDQhguEHvDyddO98fwKOq3Zcz28dQtgP6GCqKsgHpQ90hRuGI9pEP7+tVikeOxI=
Message-ID: <9a8748490610071217x45d96e05lf2448269724e750f@mail.gmail.com>
Date: Sat, 7 Oct 2006 21:17:50 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Parag Warudkar" <kernel-stuff@comcast.net>
Subject: Re: 25 random kernel configs, 24 build failures - 2.6.19-rc1-git2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <loom.20061007T185916-369@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610071102.05384.jesper.juhl@gmail.com>
	 <loom.20061007T185916-369@post.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/06, Parag Warudkar <kernel-stuff@comcast.net> wrote:
> Jesper Juhl <jesper.juhl <at> gmail.com> writes:
>
>
> > kernel/sched.c: In function `domain_distance':
> > kernel/sched.c:5673: internal compiler error: Segmentation fault
> > Please submit a full bug report,
> > with preprocessed source if appropriate.
> > See <URL:http://gcc.gnu.org/bugs.html> for instructions.
> > make[1]: *** [kernel/sched.o] Error 1
> > make: *** [kernel] Error 2
> >
> > ====================
>
> Jesper
>
> In case you haven't noticed this in the load of errors - there you have
> something to report to GCC bugzilla! (I did a quick gcc bugzilla search for
> kernel/sched.c and ICE, but did not see anything exactly similar at the least.)
>
I did notice, and I will report it, don't worry :-)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
