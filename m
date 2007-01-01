Return-Path: <linux-kernel-owner+w=401wt.eu-S1753632AbXAAN2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbXAAN2r (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 08:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbXAAN2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 08:28:47 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:22331 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbXAAN2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 08:28:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aGaVhr1xDwtosHEdfmVcf9xdO2tbXqavOAL4RGU4zUdyqnn2I3ubwqJn4Sikn/yzN2KTPeZmUl03Nw54ROPblL3DVZnhy1PakSEyC6+gqSs5TfWXOaO+1x71c1yjYyD8aQSCa1xdpile3HX9A281zbIpR80vVS+eLI2jRiV+qgc=
Message-ID: <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
Date: Mon, 1 Jan 2007 14:28:46 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
In-Reply-To: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/07, Linus Torvalds <torvalds@osdl.org> wrote:
>
> In order to not get in trouble with MADR ("Mothers Against Drunk
> Releases") I decided to cut the 2.6.20-rc3 release early rather than wait
> for midnight, because it's bound to be new years _somewhere_ out there. So
> here's to a happy 2007 for everybody.
>
> The big thing at least for me personally is that nasty shared mmap
> corruption fix, but there's a number of other changes in here, many of
> them just documentation (and some media and network drivers). Shortlog and
> diffstat appended..
>
> The git trees have been updated, and the tar-tree and patches seem to have
> finisged crawling out my poor DSL connection too.
>
> As usual, mirroring might take a while, although the delay has not been
> all that horrible lately, so it's probably going to be up-to-date by the
> time the hangovers are mostly gone.
>
> At which point the first thing on any self-respecting geek's mind should
> obviously be: "is there a new kernel release for me to try?"
>
> Right?

Right ! And this one is still broken in -rc3:

Subject    : kernel panics on boot (libata-sff)
References : http://lkml.org/lkml/2006/12/3/99
            http://lkml.org/lkml/2006/12/14/153
            http://lkml.org/lkml/2006/12/24/33
Submitter  : Alessandro Suardi <alessandro.suardi@gmail.com>
Caused-By  : Alan Cox <alan@lxorguk.ukuu.org.uk>
            commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
Handled-By : Alan Cox <alan@lxorguk.ukuu.org.uk>
Status     : people are working on a fix

Happy 2007 everyone,

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)
