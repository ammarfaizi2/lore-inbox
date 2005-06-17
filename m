Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVFQREU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVFQREU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVFQREU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:04:20 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:60735 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262012AbVFQREQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:04:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WPRBZl077y6o4Erwtx4QueYY3Bufj59zcyAh5oaU0W69XfrDbs2ukBP0CMTkqHtU8B6wLUS9Gdnl22D/3nd8OcYtX4HtjPK/FZVp+MQicwJYRnk39/NqgACoV3MNiN08+CI5HSR2HWfL5MeYl8AfnrQBjGQNRBhZmBdkrwZfm8s=
Message-ID: <9a874849050617100458c1f8b5@mail.gmail.com>
Date: Fri, 17 Jun 2005 19:04:14 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Arnd Bergmann <arndb@onlinehome.de>
Subject: Re: [resend][PATCH] avoid signed vs unsigned comparison in efi_range_is_wc()
Cc: arnd@arndb.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       eranian@hpl.hp.com, davidm@hpl.hp.com, juhl-lkml@dif.dk
In-Reply-To: <13345630.1118967959638.JavaMail.servlet@kundenserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <13345630.1118967959638.JavaMail.servlet@kundenserver>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/05, Arnd Bergmann <arnd@arndb.de> <arndb@onlinehome.de> wrote:
> Jesper wrote:
> 
> >> Jesper, are you interested in my stuff
> >
> >Certainly.
> >
> 
> Ok, here is the warning level patch for reference. I'm sending the rest of my stuff
> to you off-list since it is rather largish and I don't have a working mail client
> on this machine.
> 

Thank you. This looks useful.

I also recieved your other patches and I'll see what I can do to
double-check them, make sure they apply to current kernels and then
start submitting them to the relevant people.

Thanks.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
