Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTEJT41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTEJT41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:56:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:6539 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264489AbTEJT4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:56:24 -0400
Date: Sat, 10 May 2003 22:06:36 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <200305101549_MC3-1-3850-DE5@compuserve.com>
References: <200305101549_MC3-1-3850-DE5@compuserve.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <S264489AbTEJT4Y/20030510195625Z+7093@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003 15:46:58 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> Tuncer M "zayamut" Ayaz wrote:
> 
> > btw, I'm not 100% sure anymore now running 2.4 whether I really
> > heard the same noise just quiet. hard to differentiate and also
> > doesn't matter from my view as it doesn't annoy like the
> > 2.5 noise effect.
> > --> if it's the same noise, it would be ok, as you don't hear it
> > normally sitting in front of the box, but running 2.5 is not
> > nice with that high-pitched tone.
> 
>  1000 Hz clock in 2.5 vs. 100 Hz in 2.4 ????
> 
>  I bet that's it.

first, as you see in my other reply to Xavier Bestel disabling
"apm idle call" fixed the problem, it seems, but I didn't want
to disable those calls because of thermal reasons.

no matter what frequency it runs at I still wonder what that sound
is anyway. maybe some DELL engineers reading this could provide us
with some insight. fixing symptoms is one thing, knowing the reason
and background info much more important to me.
