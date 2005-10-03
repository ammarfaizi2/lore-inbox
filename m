Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbVJCSjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbVJCSjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVJCSjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:39:13 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:15714 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751170AbVJCSjM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:39:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FJl70rMJFHjEflxYgQbRDl5+7hjbFtypQ7SoeLqzowXh1gyTig468wKmlPL++FStUBdJeOSVY/E2+QPMkCnyggi8vjgoD68AvWFav0kud26flWBi5bNct6zoR+XMHcNWexUXlmUA1E3wfKwrH8Cmtg9QUTp0oQHnA4/AvAnF0BQ=
Message-ID: <9a8748490510031139t18bfb2a3va41dab0e3f1bb58a@mail.gmail.com>
Date: Mon, 3 Oct 2005 20:39:10 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Fernando Rocha <frocha@student.dei.uc.pt>
Subject: Re: [KORG] Kernel Panic
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <43414E0A.3090506@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43414E0A.3090506@student.dei.uc.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Fernando Rocha <frocha@student.dei.uc.pt> wrote:
> Hi linux-kernel staff.
>
>     I have a big problem!
>     Each time I try to intall an Linux OS, on my machine, it crashes
> with "Kernel Panic"!

We'll need a bit more detail than that.
Please provide the entire crash dump message exactely as it is printed
on your screen.
Please provide as much of the bootup log as you can - using a serial
console or netconsole to capture boot messages may be a good option
(See the text files describing this in the kernel source
Documentation/ directory for details).
Please tell us the kernel version.
Please read the REPORTING-BUGS file in the kernel source dir (or use
this link: http://sosdg.org/~coywolf/lxr/source/REPORTING-BUGS ).


[snip]
>     None of the Linux OS were able to detect the best "window size" of
> the screen,
> so I had to manually input it!!
>
Irrelevant.
Not a kernel issue. Talk to the distribution people and/or the X
people about that.


[snip hardware details]
>
> Could it be something about the "Hyperthreading" thing, or hard drive
> being SATA,
> or maybe the 3D Board because of not detecting it??

Possibly.
Impossible to tell with out the actual crash dump.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
