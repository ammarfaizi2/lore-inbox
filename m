Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVJaIzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVJaIzP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 03:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVJaIzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 03:55:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25568 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932191AbVJaIzN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 03:55:13 -0500
Date: Mon, 31 Oct 2005 01:54:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?Um9n6XJpbw==?= Brito <rbrito@ime.usp.br>
Cc: rob@landley.net, ak@suse.de, rmk+lkml@arm.linux.org.uk, torvalds@osdl.org,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051031015427.5634f744.akpm@osdl.org>
In-Reply-To: <20051031084748.GB3087@ime.usp.br>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051030111241.74c5b1a6.akpm@osdl.org>
	<200510310148.57021.ak@suse.de>
	<200510302305.46532.rob@landley.net>
	<20051030231723.71c72865.akpm@osdl.org>
	<20051031084748.GB3087@ime.usp.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito <rbrito@ime.usp.br> wrote:
>
>  Oh, and I would really appreciate if some options had at least some
>  description when I do a make menuconfig. Would identifying these options
>  or asking for clarification of others be of any interest?

Yes please - people often seem to omit the help text.

Better still is to send a patch which adds the help text, of course.  If
it's a bit wrong, people will help sort that out.
