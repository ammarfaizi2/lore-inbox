Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUJLQCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUJLQCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUJLQCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:02:25 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:10194 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266009AbUJLP7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:59:05 -0400
Date: Tue, 12 Oct 2004 17:59:42 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-ID: <20041012155942.GG17372@dualathlon.random>
References: <20041012142417.GD17372@dualathlon.random> <Pine.LNX.4.44.0410121130400.13693-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410121130400.13693-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 11:32:57AM -0400, Rik van Riel wrote:
> On Tue, 12 Oct 2004, Andrea Arcangeli wrote:
> 
> > here a new patch, possibly candidate for merging in 2.6.10pre?
> > 
> > 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9-rc4/seccomp
> 
> How do you start a seccomp process in a secure way ?

there's an example here:

http://www.cpushare.com/download/cpushare-0.4.tar.bz2

check python seccomp_test.py and seccomp-loader.c.
