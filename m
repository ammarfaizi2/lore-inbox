Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbTGVNTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 09:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270179AbTGVNTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 09:19:34 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:42251 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S269409AbTGVNTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 09:19:33 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.22pre6aa1
Date: Tue, 22 Jul 2003 14:28:03 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <20030717102857.GA1855@dualathlon.random> <20030717225002.GY1855@dualathlon.random> <1058488216.4016.338.camel@tiny.suse.com>
In-Reply-To: <1058488216.4016.338.camel@tiny.suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307221428.03791.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 July 2003 02:30, Chris Mason wrote:

Hi Chris,

> > If this doesn't help at all, it might not be an elevator/blkdev thing.
> > At least on my machines the contigous I/O still at the same speed.
> Especially with just one writer, you really shouldn't be able to see a
> difference in pre6.  Did you measure this change on both pre6 and
> pre6aa1.  Your message indicated that but I wanted to double check to
> make sure.
Yes, I measured it with pre6 and pre6aa1. There is no noticable difference.

ciao, Marc


