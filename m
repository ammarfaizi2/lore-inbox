Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbULQRbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbULQRbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 12:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbULQRbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 12:31:20 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:696 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262080AbULQRbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 12:31:06 -0500
Subject: Re: 2.6.10-rc2-mm4 panic while running LTP tests
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041216170401.498a04dd.akpm@osdl.org>
References: <1103242646.5383.31.camel@dyn318077bld.beaverton.ibm.com>
	 <20041216170401.498a04dd.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1103303301.5383.56.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Dec 2004 09:08:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 17:04, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > I get following panic while running LTP io tests.
> 
> Which one, and with what arguments, on what hardware?

I have no idea, it happens 1 hour into the run. 
I am runing aio-dio tests on AMD64.

> 
> > I am going to try 2.6.10-rc3-mm1 next,
> 
> Thanks.
> 
> > but are there are any recent changes in this area ? 
> 
> There are changes everywhere, but nothing comes to mind..

Okay. I will see what I can do to narrow it down.

Thanks,
Badari

