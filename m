Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965050AbVKOW1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVKOW1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVKOW1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:27:23 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:41192 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965050AbVKOW1X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:27:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t0Y/aG6djjB+UJeTC7LHHIqaHlKuu/dE1x0G+B0/rRCeRmgjl0nvEQnNrJKvxBX2wkU1tMeDIINgdrNDkuJcNThjfKlohENCoCpJ+wv0SugPrQlpMBJDmozPk1AXZTt44O9o8eccRuuY5cTThdivuBy8xqGnUpWe3Wl/6G1949o=
Message-ID: <9a8748490511151427r549b7e0ah6a443fe1fd8e996f@mail.gmail.com>
Date: Tue, 15 Nov 2005 23:27:22 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20051115210459.GA11363@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051115210459.GA11363@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Greg KH <gregkh@suse.de> wrote:
> Here's an updated version of the "HOTO do Linux kernel development"
> document that I've been working on.
>
[snip]

A few suggestions;

You point to a lot of documents, but never mention the main kernel
README nor Documentation/Changes . I think you should.

The README provides good info on configuring, building and installing
the kernel and other bits that will be useful to new kernel
developers.
Similarly the Documentation/Changes document provides important info
on required versions of tools needed to build and/or use the kernel.
Making new developers aware of this info is important so they can
verify their environment is up-to-date for the kernel version they
work on.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
