Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUGZInS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUGZInS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 04:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUGZInS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 04:43:18 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:35005 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265051AbUGZInM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 04:43:12 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Autotune swappiness01
Date: Mon, 26 Jul 2004 10:52:49 +0200
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <cone.1090803691.689003.20693.502@pc.kolivas.org> <cone.1090804198.848689.20693.502@pc.kolivas.org>
In-Reply-To: <cone.1090804198.848689.20693.502@pc.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407261052.50178.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 of July 2004 03:09, Con Kolivas wrote:
> Con Kolivas writes:
> > Andrew Morton writes:
> >> Seriously, we've seen placebo effects before...
> >
> > I am in full agreement there... It's easy to see that applications do not
> > swap out overnight; but i'm having difficulty trying to find a way to
> > demonstrate the other part. I guess timing the "linking the kernel with
> > full debug" on a low memory box is measurable.
>
> I should have said - finding a swappiness that ensures not swapping out
> applications with updatedb, then using that same swappiness value to do the
> linking test.

Please excuse me, but is that viable at all?  IMHO, it's just like trying to 
tune a radio including volume with only one knob.  I don't say it won't work, 
but the probability that it will is rather small, it seems ...

rjw

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
