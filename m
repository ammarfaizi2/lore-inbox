Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWBQJRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWBQJRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 04:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbWBQJRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 04:17:23 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:28189 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161117AbWBQJRW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 04:17:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d16EAol/AK5XOaA3b6Blf76DDY71C04fQrbYt9x/+tXMEYHBDdirIZCmXSyvd7uGvpJFHj3VS2fpv8Z3sByjSTDdNkX5j7UpVyqxktSwZ/lfl08ySzfB/knEj0hF16GE3qkEQ4fZ0gacjtnsydgwdsPmH+iaxby0zIe01oiHjPc=
Message-ID: <9a8748490602170117g43ec9e4aw1b1924860e9b3c96@mail.gmail.com>
Date: Fri, 17 Feb 2006 10:17:21 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.16-rc3-git7 build failure if sysfs disabled
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060217004426.GA19357@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490602161542k1b282097ub754e6f0287780d2@mail.gmail.com>
	 <20060217004426.GA19357@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/06, Greg KH <greg@kroah.com> wrote:
> On Fri, Feb 17, 2006 at 12:42:01AM +0100, Jesper Juhl wrote:
> > 2.6.16-rc3-git7 fails to build when sysfs is disabled with the
> > attached .config .
> >
> > Without sysfs enabled :
>
> Yeah, someone else pointed this out a while ago too.  Care to make up a
> patch to fix it?
>

I don't mind taking a crack at it, but it won't be until saturday
evening or sunday, don't have any spare time before then - that's why
I just send in the info instead of trying to fix it myself.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
