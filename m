Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbTATTgK>; Mon, 20 Jan 2003 14:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266777AbTATTgK>; Mon, 20 Jan 2003 14:36:10 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:56300 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S266772AbTATTgI>; Mon, 20 Jan 2003 14:36:08 -0500
From: David Lang <david.lang@digitalinsight.com>
To: David Schwartz <davids@webmaster.com>
Cc: dana.lacoste@peregrine.com, linux-kernel@vger.kernel.org
Date: Mon, 20 Jan 2003 11:31:53 -0800 (PST)
Subject: Re: Is the BitKeeper network protocol documented?
In-Reply-To: <20030120190037.AAA15691@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.4.44.0301201129510.6894-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so are you saying it's illegal for an opensource project to use a
commercial version control system, or that use of such a version control
system by a GPL project forces the companty to GPL their version control
system?

since stallman has already said neither of these is the case I'm curious
as to exactly what you are trying to say the requirements are.

David Lang


 On Mon, 20 Jan 2003, David Schwartz wrote:

> Date: Mon, 20 Jan 2003 11:00:35 -0800
> From: David Schwartz <davids@webmaster.com>
> To: dana.lacoste@peregrine.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Is the BitKeeper network protocol documented?
>
> On 20 Jan 2003 09:28:35 -0500, Dana Lacoste wrote:
>
> >On Sun, 2003-01-19 at 20:05, David Schwartz wrote:
>
> >>    Don't blame me. The GPL just says the "preferred" form and
> >>leaves
> >>us
> >>to wonder. As I understand it, however, you cannot ship binaries of
> >>a
> >>GPL'd project unless you can distribute the source code in the
> >>"preferred form .. for making modifications to it".
>
> >The GPL specifically allows for multiple methods of accessing the
> >'preferred form' including FTP, including the source in the
> >distribution, etc.  BitKeeper is nothing more than another method
> >to access that 'preferred source'.
>
> 	I think you're entirely dropping the context. If the development of
> a project is centered around a version control system, then that
> version control system contains metainformation that is useful when
> you're making modifications.
>
> 	In this case, the raw source code, less the change history and check
> in comments, would not actually be the preferred form of the source
> code for the purpose of making modifications. This has nothing to do
> with how you get the information but what information you get.
>
> >Please stop this.  You're looking kind of silly here.
>
> 	Only because you are misrepresenting my argument.
>
> 	Let me give you a hypothetical. There's a program and you have to
> make some changes to it. Would you prefer to have the raw source code
> or the source code with change history and commit comments? I'm not
> talking about how you get either set of information, I'm talking
> about what information you get.
>
> 	Checking code out of a repository is as much an act of obfuscation
> as stripping comments.
>
> >PS: nobody said 'IANAL' yet.  meaning you're just a noisy peanut
> >gallery
>
> 	Any lawyer who claimed he or she could predict how a court would
> interpret this clause of the GPL is lying to you. That is why it is
> essentially impossible to be sure you comply with this.
>
> 	DS
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
