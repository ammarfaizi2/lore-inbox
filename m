Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVIEEDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVIEEDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 00:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVIEEDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 00:03:16 -0400
Received: from web50204.mail.yahoo.com ([206.190.38.45]:57205 "HELO
	web50204.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932190AbVIEEDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 00:03:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ped/Yzs2irgLdBgie1tsQ83i/DMAuvBSwaUxLXR8q5o0tFxEsxGpneM5gNlRdT/2QeoVtkyW1ygaqGzbxrzXfLhi19j2p8gZttyXWmCKCQrfnNm10YZJncDNEGsjrWDlEyzlUYLqRRoJ2mQR54KUZ9nvx39lkdnUaC2FZ5ffZto=  ;
Message-ID: <20050905040311.29623.qmail@web50204.mail.yahoo.com>
Date: Sun, 4 Sep 2005 21:03:11 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: re: RFC: i386: kill !4KSTACKS
To: Sean <seanlkml@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <35547.10.10.10.10.1125892279.squirrel@linux1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Sean <seanlkml@sympatico.ca> wrote:

> On Sun, September 4, 2005 11:41 pm, Alex Davis said:
> 
> > It will never be 'appropriate' if the system doesn't somehow work on Joe's
> > hardware. We currently have something that works. In my opinion it's
> > pointless to take that away. The manufacturers will still stone-wall us
> > regardless of ndiswrapper's existence. They were doing it before ndis-
> > wrapper existed.
> 
> There are lots and lots of systems where Linux works.  Encouraging users
> to buy hardware that works with Linux, can only help.  Encouraging them
> that it doesn't matter and that binary-only drivers are a good
> alternative, can only hurt.
> 
> > Please explain how Linux can be an 'important force' if people can't
> > use it? Wireless networking is very important to people.
> 
> Lots of people can and do use Linux without ANY binary drivers.   There
> are Wireless choices that don't require binary only drivers.
What if you don't have a choice? When someone comes to me with their laptop
containing a built-in wireless card not natively supported by Linux, am I
supposed to tell them "go buy a Linux-supported card" when there's a way
I can make their existing card work? I don't think so.

> > Um, ever hear of 'compromise'?? All I'm saying is let people use what
> > currently works until we can get an open-source solution. Ndiswrapper's
> > existence is not stopping you (or anyone else) from pestering
> > manufacturers
> > for spec's and writing drivers. I look at ndiswrapper as a stop-gap
> > solution.
> > Hey, even Linus himself has said 'better a sub-optimal solution than no
> > solution'.
> 
> Nobody is stopping anyone from using what "currently works", there will be
> lots of like minded people to provide crap kernels and shitty binary
> drivers to people who don't know better. 
>  So don't worry, your well
> intentioned vision of the future will survive the removal of 8K stacks
> from the kernel.

> Regards,
> Sean
> 
> 
> 


I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
