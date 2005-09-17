Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbVIQEar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbVIQEar (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 00:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVIQEar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 00:30:47 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:52104 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750881AbVIQEar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 00:30:47 -0400
Subject: Re: 2.6.13-mm2
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1126930657.7927.5.camel@localhost>
References: <200509162038_MC3-1-AA6D-60D9@compuserve.com>
	 <1126930657.7927.5.camel@localhost>
Content-Type: text/plain
Date: Sat, 17 Sep 2005 00:30:34 -0400
Message-Id: <1126931434.8239.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-17 at 00:17 -0400, Parag Warudkar wrote:
> On my machine asm-i386/user.h and
> asm-x86_64/user.h both do not contain a user_regs_struct definition
> with
> x86 registers. 

Never mind - Ubuntu seems to have broken compat headers. (Kernel version
of asm-i386/user.h is appropriate.)

P

