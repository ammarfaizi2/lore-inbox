Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVDYAFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVDYAFp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 20:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVDYAFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 20:05:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:50872 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262491AbVDYAFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 20:05:40 -0400
Subject: Re: 2.6.12-rc2-mm3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <87u0lvpy6f.fsf@blackdown.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
	 <87wtr8rdvu.fsf@blackdown.de> <87u0m7aogx.fsf@blackdown.de>
	 <1113607416.5462.212.camel@gaston> <877jj1aj99.fsf@blackdown.de>
	 <20050423170152.6b308c74.akpm@osdl.org> <87fyxhj5p1.fsf@blackdown.de>
	 <1114308928.5443.13.camel@gaston> <426B6C84.E8D41D57@tv-sign.ru>
	 <87u0lvpy6f.fsf@blackdown.de>
Content-Type: text/plain
Date: Mon, 25 Apr 2005 10:09:46 +1000
Message-Id: <1114387786.31594.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-25 at 01:11 +0200, Juergen Kreileder wrote:
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > Juergen Kreileder wrote:
> >>
> >> It only happens when running Azareus with IBM's Java (our's isn't
> >> ready yet).  So far I was able to reproduce the problem on all -mm
> >> versions within one hour.  Otherwise the kernels seem to work fine
> >> -- no lockup unless I run Azareus.
> >
> > By any chance, could you please try this patch?
> 
> Doesn't help.

Ok, try to mail me privately a HOWTO to reproduce your exact testcase,
knowing that I don't know anything about this Azareus thing ...

Ben.


