Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263005AbTC0PlB>; Thu, 27 Mar 2003 10:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbTC0PlB>; Thu, 27 Mar 2003 10:41:01 -0500
Received: from mail.ithnet.com ([217.64.64.8]:4623 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S263005AbTC0PlA>;
	Thu, 27 Mar 2003 10:41:00 -0500
Date: Thu, 27 Mar 2003 16:52:01 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Patrick McHardy <kaber@trash.net>
Cc: chris@sigsegv.plus.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-Id: <20030327165201.12d2ef86.skraw@ithnet.com>
In-Reply-To: <3E82F00F.7@trash.net>
References: <20030326162538.GG2695@spackhandychoptubes.co.uk>
	<20030326185236.GE24689@kroah.com>
	<20030326192520.GH2695@spackhandychoptubes.co.uk>
	<20030326193437.GI24689@kroah.com>
	<20030327111600.GI2695@spackhandychoptubes.co.uk>
	<3E82F00F.7@trash.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003 13:35:27 +0100
Patrick McHardy <kaber@trash.net> wrote:

> The ISDN bug is fixed, i sent a patch to LKML and the Maintainer last week.
> I've attached the fix again, the one in isdn_ppp.c is responsible for 
> the BUG()s.

It seems I can confirm that. Your patch indeed fixes my problem. 

Thanks a lot
Stephan



