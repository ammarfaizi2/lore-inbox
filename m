Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbVKVEV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVKVEV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 23:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKVEV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 23:21:26 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:51848 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932190AbVKVEVZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 23:21:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gTiHZbkA8kbOptLSYrQhuSDk2j6ATMuLtfKXxk0sgxaYXt53hHdlD9Qbz/3kzpTEvRKjpe08ntMJYbndssnYcm0laUcBTTdroW2stUcDYuHVMIXiPBzu8Ig4CeQtHcc/zTndSCkctJhz1VGq197ve7TqWA0hzLzBpl/wlqTNkxc=
Message-ID: <35fb2e590511212021j51dc8fd2ia949e3d8282d3cee@mail.gmail.com>
Date: Tue, 22 Nov 2005 04:21:24 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
Cc: Andrew Morton <akpm@osdl.org>, Cal Peake <cp@absolutedigital.net>,
       linux-kernel@vger.kernel.org, jcm@jonmasters.org, viro@ftp.linux.org.uk,
       hch@lst.de
In-Reply-To: <Pine.LNX.4.64.0511211914470.13959@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
	 <20051116005958.25adcd4a.akpm@osdl.org>
	 <20051119034456.GA10526@apogee.jonmasters.org>
	 <Pine.LNX.4.64.0511211914470.13959@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/05, Linus Torvalds <torvalds@osdl.org> wrote:

> On Sat, 19 Nov 2005, Jon Masters wrote:
> >
> > I stuck a test in for first use and had floppy_release free up policy
> > too. But there are a bunch of problems in the floppy driver I've noticed
> > in going through it tonight (and there's only so much of that I can take
> > at 03:43 on a Saturday morning). I'll hopefully followup again.

> Can you do one that is against your previous patch that already got
> merged through Andrew? And sign off on it?

Yeah, since I hate sleep. It's just test compiling, will mail in (my) morning.

Jon.
