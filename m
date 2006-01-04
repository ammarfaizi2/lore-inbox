Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWADTyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWADTyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 14:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWADTyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 14:54:25 -0500
Received: from mail.linicks.net ([217.204.244.146]:16768 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S965276AbWADTyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 14:54:24 -0500
From: Nick Warne <nick@linicks.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Wed, 4 Jan 2006 19:53:15 +0000
User-Agent: KMail/1.9
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
References: <200601041710.37648.nick@linicks.net> <200601041739.59982.nick@linicks.net> <200601041834.23722.s0348365@sms.ed.ac.uk>
In-Reply-To: <200601041834.23722.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601041953.15735.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 18:34, Alistair John Strachan wrote:
> On Wednesday 04 January 2006 17:39, Nick Warne wrote:
> > On Wednesday 04 January 2006 17:36, Randy.Dunlap wrote:
> > > > I went from 2.6.14 -> 2.6.14.2 -> .2-.3 -> .3-.4 -> .4-.5
> > >
> > > and how did you do that?
> > > Noone supplies such incremental patches AFAIK.
> >
> > Yes, I got from kernel.org - I am _not_ that clever to devise my own
> > incremental patches, otherwise I wouldn't be asking stupid questions...
>
> Nick's right, both are provided automatically by kernel.org.

Anyway, I started from scratch - 2.6.14, patched to 2.6.15 and then make 
oldconfig etc.

I think there needs to be a way out of this that is easily discernible - it 
does get confusing sometimes with all the patches flying around on a 'stable 
release'.

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
My quake2 project:
http://sourceforge.net/projects/quake2plus/
