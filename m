Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292133AbSBOVMu>; Fri, 15 Feb 2002 16:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292131AbSBOVMl>; Fri, 15 Feb 2002 16:12:41 -0500
Received: from [208.29.163.248] ([208.29.163.248]:57237 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S292130AbSBOVMg>; Fri, 15 Feb 2002 16:12:36 -0500
Date: Fri, 15 Feb 2002 13:11:09 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Robert Love <rml@tech9.net>
cc: J Sloan <jjs@lexus.com>, john slee <indigoid@higherplane.net>,
        J Sloan <joe@tmsusa.com>, <linux-kernel@vger.kernel.org>
Subject: Re: tux officially in kernel?
In-Reply-To: <1013730883.807.251.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0202151309090.2991-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Feb 2002, Robert Love wrote:

> On Thu, 2002-02-14 at 18:33, J Sloan wrote:
>
> > So, just out of curioisity, why is khttpd in
> > the kernel? If there were any web server
> > in the mainline kernel I'd think it'd be tux -
>
> Personally khttpd should be ripped from the kernel.  It is a nice, uh,
> example.  Or something.

Linus put khttpd in the kernel just after sendfile support was added, IIRC
he said something about khttpd being a very small number of lines to add
once sendfile support was there.

if it's really that small (IIRC <<100 lines of code) it's still in there
becouse it's not worth ripping out.

David Lang
