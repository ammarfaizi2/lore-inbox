Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292456AbSBZTuO>; Tue, 26 Feb 2002 14:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292754AbSBZTuE>; Tue, 26 Feb 2002 14:50:04 -0500
Received: from pop.gmx.de ([213.165.64.20]:30258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S292456AbSBZTtx>;
	Tue, 26 Feb 2002 14:49:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
Date: Tue, 26 Feb 2002 20:42:27 +0100
X-Mailer: KMail [version 1.3.99]
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101FE2@nocmail.ma.tmpw.net> <Pine.LNX.4.21.0202251613300.31438-100000@freak.distro.conectiva> <20020226174602.4f4b30bc.skraw@ithnet.com>
In-Reply-To: <20020226174602.4f4b30bc.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200202262042.27501.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 26. Februar 2002 17:46:17 schrieb Stephan von Krawczynski:
> On Mon, 25 Feb 2002 16:18:46 -0300 (BRT)
>
> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> > [...]
> > The patch which I missed only breaks static apps on _some_ architectures
> > (not including x86).
>
> This statement is not very nice. You obviously classify these architectures
> as minor important. At least not important enough to give them a release
> version as bugfree as possible at the given time. You shouldn't do that,
> don't focus on what you classify the "mainstream" too much. As stated
> before, there is no problem with making mistakes. You only have to handle
> the situation in an intelligent manner _and_ aware of the power given to
> you. In my eyes, the clean choice would have been 2.4.19 release.
> [...]
> Regards,
> Stephan

Mhm, I'm not a kernel developer but I think that people how need the newest 
kernel can also use a patch. In this case 2.4.19 pre1 which doesn't need much 
time.

So I see no Problem.
I think Marcelo does his work well.

If anyone needs a new kernel, your dist will have well tested working kernels 
for your arch.

If a person has a special arch, he must know how to patch a kernel.


So there is no need to make special things for __any__ architecture.
The final release is fine and very usefull, but if you have problems with it, 
you should be able to use the pre versions from the next release.


I only write this, because I don't like it that people say: The 2.4.x is too 
buggy, you miss some of the other archs, I need a wallpaper in the background 
of my xconfig.

I am a user, I make mistakes with the configuration of the kernel.
I use new kernel, but if something goes wrong I know that it's my fault, 
because I don't want to wait.

Mhm, should be enough ;)

thanks for all people who work on Open Source products

have fun
Felix Seeger
