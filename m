Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUAESbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUAESbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:31:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:50314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265267AbUAESbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:31:07 -0500
Date: Mon, 5 Jan 2004 10:31:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1 affected?
In-Reply-To: <1073326471.21338.21.camel@midux>
Message-ID: <Pine.LNX.4.58.0401051027430.2115@home.osdl.org>
References: <1073320318.21198.2.camel@midux>  <Pine.LNX.4.58.0401050840290.21265@home.osdl.org>
 <1073326471.21338.21.camel@midux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, Markus Hästbacka wrote:
>
> Why isn't there any security update to 2.6.0/2.6.1-rc1 out yet, then?

Because nobody actually contacted me about the problem and I read about it
on linux-kernel like everybody else? Because I just got up and created the
patch? And because nobody has an exploit yet, and one may be hard or
impossible to create? And because people who care about these things tend
to not update to x.0 kernels anyway?

> But I think there's corporations who use 2.6.0 and don't read the lkml.

They'll get a 2.6.1 soonish. The patch is in the current BK tree, will be 
in -rc2, and will be in 2.6.1. Let's just make sure we don't screw up the 
release due to being too much in a hurry either..

			Linus
