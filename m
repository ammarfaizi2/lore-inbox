Return-Path: <linux-kernel-owner+w=401wt.eu-S1030215AbWL3B5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbWL3B5d (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 20:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWL3B5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 20:57:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3820 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030215AbWL3B5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 20:57:32 -0500
Date: Sat, 30 Dec 2006 02:57:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Ben Collins <ben.collins@ubuntu.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Daniel Holbach <daniel.holbach@ubuntu.com>
Subject: Re: 2.6.20-rc2: known unfixed regressions
Message-ID: <20061230015734.GV20714@stusta.de>
References: <20061229192525.GU20714@stusta.de> <200612300121.kBU1LaiQ017876@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612300121.kBU1LaiQ017876@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 10:21:36PM -0300, Horst H. von Brand wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> [...]
> 
> > Subject    : BUG at fs/buffer.c:1235 when using gdb
> > References : http://lkml.org/lkml/2006/12/17/134
> > Submitter  : Andrew J. Barr <andrew.james.barr@gmail.com>
> > Fixed-By   : Jeremy Fitzhardinge <jeremy@goop.org>
> > Commit     : 8701ea957dd2a7c309e17c8dcde3a64b92d8aec0
> > Status     : fixed in -rc2
> 
> This I see in Fedora rawhide i686 2.6.19-1.2891.fc7 (BZ'd at
> <https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=220855>

2.6.19-1.2891.fc7 is based on 2.6.20-rc1-git5, and it's therefore 
expected that it contains this bug.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

