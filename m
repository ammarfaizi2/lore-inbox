Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275283AbTHMRNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275284AbTHMRNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:13:33 -0400
Received: from 12-254-105-101.client.attbi.com ([12.254.105.101]:23823 "EHLO
	gw.kuetemeier.com") by vger.kernel.org with ESMTP id S275283AbTHMRNc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:13:32 -0400
Subject: Re: [PATCH][DOCO] Re: 2.6.0-test3 and dnotify
From: Ronald Kuetemeier <ron_ker@kuetemeier.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus <torvalds@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813143751.3dc0b14b.sfr@canb.auug.org.au>
References: <1060705727.1189.12.camel@ronald.kuetemeier.com>
	 <20030813143751.3dc0b14b.sfr@canb.auug.org.au>
Content-Type: text/plain
Organization: 
Message-Id: <1060794788.1145.22.camel@ronald.kuetemeier.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Aug 2003 11:13:09 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan, 
I most certainly will give it a shot.  But why is it working under 2.4.X
iff glibc or bash are blocking SIGRTMIN, they should also block under
2.4.x or is there a bug in 2.4.x which prevents it?

Thanks for your help,
Ronald



On Tue, 2003-08-12 at 22:37, Stephen Rothwell wrote:
> Linus,
> 
> On 12 Aug 2003 10:28:47 -0600 Ronald Kuetemeier <ron_ker@kuetemeier.com> wrote:
> >
> > I run some of my programs on 2.6.0-test3 this morning, before my coffee
> > ..., anyhow seems dnotify isn't working any more. I compiled the example
> > from <linux-2.6.0-test3>/Documentation/dnotify.txt this also doesn't
> > work anymore.
> 
> This has been asked a couple of times, so can you please apply the
> following documentation patch?

