Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbTEKTRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 15:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbTEKTRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 15:17:16 -0400
Received: from mail.gmx.net ([213.165.65.60]:7811 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261171AbTEKTRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 15:17:15 -0400
Date: Sun, 11 May 2003 21:27:30 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <200305102231_MC3-1-384E-4E4C@compuserve.com>
References: <200305102231_MC3-1-384E-4E4C@compuserve.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <S261171AbTEKTRP/20030511191715Z+7439@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003 22:28:10 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> > first, as you see in my other reply to Xavier Bestel disabling
> > "apm idle call" fixed the problem, it seems, but I didn't want
> > to disable those calls because of thermal reasons.
> 
>   Maybe you could set 2.5 to run at 100 Hz?  I don't know
> if that's possible, but it could let you test if that's what
> makes the noise so much more annoying.

yep that is true, tried 2.4 with "APM idle calls" enabled and
there was that noise - just at 100hz :D
would be interesting to know how many laptops have such issues.
