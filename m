Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVKOBIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVKOBIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVKOBIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:08:32 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:6245 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751275AbVKOBIb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:08:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tFcRkVgjkCSjPuI5TNE4SCpyyQl8TtF3fVSoaQubDwdpF+OwBlwB7GMKbxxaYlIBSPCiCARHcRUrY20hs22Hid5NBeIUt5QYX78ccRN0lBki3xiSjYtbdfg47oc7ElVfFX5zUAuQpusZHdxEIWOZlnz9pyftOocTBRjSg0qc1N0=
Message-ID: <2cd57c900511141708y5d11fd34n@mail.gmail.com>
Date: Tue, 15 Nov 2005 09:08:30 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] HOWTO do Linux kernel development
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20051114220709.GA5234@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051114220709.GA5234@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/15, Greg KH <gregkh@suse.de>:
> Over time, I get a lot of the same kind of emails from developers.
> Messages asking how to do this or that, or how this process works.  I
> also see a lot of new developers make the same mistakes (wrong patch
> format, no signed-off-by:, not sent to the proper developer, wrong
> coding style, etc.)
>
> Along with these requests, I have heard a lot of complaints over time,
> about how there is no single place to go to to figure out how to do
> Linux kernel development, and where to point other people to.
>
> So, I've been working on a document for the past week or so to help
> alleviate a lot of these problems.  If nothing else, it should be a place
> where anyone can point someone to when they ask the common questions, or
> do something in the not-correct way.  I'd like to add this to the Linux
> kernel source tree, so it will be kept up to date over time, as things
> change (like the development process.)  Ideally I'd like to put it in
> the main directory as HOWTO, but I don't know how others feel about

You put it in the top directory to draw the most attention? Compare to
source trees of other kernel projects, Linux source tree looks clean.
Please don't spoil that. What's wrong with Documentation/ ?

> this.
>
> Anyway, I'd like to get comments on what has been produced so far.  I
> know the section about the development process is still not complete (it
> has a <TODO> mark), and if anyone wants to fill that in, I'd really
> appreciate it.
>
> I would like to thank Pat Mochel, Hanna Linder, Randy Dunlap, Kay
> Sievers, Vojtech Pavlik, and Jan Kara for their review and comments on
> early drafts of this document.
>

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
