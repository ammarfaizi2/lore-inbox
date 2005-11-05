Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVKEOee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVKEOee (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 09:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVKEOee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 09:34:34 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:27154 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751183AbVKEOed convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 09:34:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l4E3714dYNkYgBclLT/7pc9fDfZ7WTgDJRNkQUh2pmZOClDLe/LY/JEpYay5Ci498byTeEcrUgfXGyYZEdsUCJhEAOVz1Bb5dP6GakJDaLQKWEhGPVb5laU6nKr6Wk3T1YfbShqmodSTpnxli7RZqQ9iGod9NDpWhrRZKiR2HGY=
Message-ID: <9a8748490511050634g8d19652w8148a3db4e3e11b2@mail.gmail.com>
Date: Sat, 5 Nov 2005 15:34:33 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Edgar Hucek <hostmaster@ed-soft.at>
Subject: Re: New Linux Development Model
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <436CB162.5070100@ed-soft.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436C7E77.3080601@ed-soft.at>
	 <20051105122958.7a2cd8c6.khali@linux-fr.org>
	 <436CB162.5070100@ed-soft.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/05, Edgar Hucek <hostmaster@ed-soft.at> wrote:
> Hi.
>
> Sorry for not posting my Name.
>
> Maybe you don't understand what i wanted to say or it's my bad english.
> The ipw2200 driver was only an example. I had also problems with, vmware,
> unionfs...
> What i mean ist, that kernel developers make incompatible changes to the
> header
> files, change structures, interfaces and so on. Which makes the kernel
> releases
> incompatible.
> There are several reasons why modules are not in the mainline kernel and
> will never
> get there. So saying, bring modules to the kernel is wrong.
> The right way would be to take care of defined interfaces, header files,
> and so on.
> Otherwise you could only say the kernel 2.6.14 is only compatible to
> 2.6.14.X and
> you there is no stable 2.6 mainline kernel.
> I think it's also no task for the user, to search the net why external
> driver xyz not
> works with a new kernel ( because of incompatibilties ). Basicly in new
> kernel there
> could be a chance for the user a driver works better, because a bug was
> fixed in the
> kernel.
> Hopefully this time it's more clear why i blame the development process
> and i'm a
> so frustrated linux user.
>

There is a very simple solution to your problem. Use the kernels
provided by your distribution and not the kernel.org kernels.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
