Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274897AbTHFHeW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274899AbTHFHeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:34:22 -0400
Received: from CPE-144-132-162-109.nsw.bigpond.net.au ([144.132.162.109]:61166
	"EHLO tigers-lfs.local") by vger.kernel.org with ESMTP
	id S274897AbTHFHeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:34:21 -0400
Date: Wed, 6 Aug 2003 17:33:41 +1000
From: Greg Schafer <gschafer@zip.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 oops - NPTL triggered
Message-ID: <20030806073341.GA1849@tigers-lfs.nsw.bigpond.net.au>
References: <20030806021316.GA408@tigers-lfs.nsw.bigpond.net.au> <20030805221739.48816e08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805221739.48816e08.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 10:17:39PM -0700, Andrew Morton wrote:
> Greg Schafer <gschafer@zip.com.au> wrote:
> >
> > An otherwise fine running kernel-2.6.0-test2 repeatably gives this when
> >  running the NPTL testsuite.
> 
> From where does one obtain the NPTL testsuite?

It's part of the NPTL package which is provided as an addon to glibc:-

https://listman.redhat.com/archives/phil-list/2003-August/msg00000.html

Greg
