Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUIXEjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUIXEjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUIXEju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:39:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:37784 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267679AbUIXEjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:39:03 -0400
Date: Thu, 23 Sep 2004 21:36:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: raybry@sgi.com, alexn@telia.com, linux-kernel@vger.kernel.org
Subject: Re: lockmeter in 2.6.9-rc2-mm2
Message-Id: <20040923213637.11a6849b.akpm@osdl.org>
In-Reply-To: <20040924042807.GU9106@holomorphy.com>
References: <41539FC1.7040001@sgi.com>
	<20040923212106.7a89b3af.akpm@osdl.org>
	<20040924042807.GU9106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Ray Bryant <raybry@sgi.com> wrote:
> >> Does the x86_64 stuff compile now?
> 
> On Thu, Sep 23, 2004 at 09:21:06PM -0700, Andrew Morton wrote:
> > yup.  I do regular x86 and x86_64 allfooconfig builds.  I'd do so on
> > sparc64/ppc64/ia64 too, if they had a chance of compiling :(
> 
> All it takes is grunt work to fix these; so how badly do you want them
> fixed?
> 

Well not greatly, except that each compile failure is usually due to a real
bug.  Ditto all the warnings, actually.
