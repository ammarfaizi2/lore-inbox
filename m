Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSD1QRU>; Sun, 28 Apr 2002 12:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311701AbSD1QRT>; Sun, 28 Apr 2002 12:17:19 -0400
Received: from family.zawodny.com ([63.174.200.26]:61368 "EHLO
	family.zawodny.com") by vger.kernel.org with ESMTP
	id <S311564AbSD1QRS>; Sun, 28 Apr 2002 12:17:18 -0400
Date: Sun, 28 Apr 2002 09:17:13 -0700
From: Jeremy Zawodny <Jeremy@Zawodny.com>
To: Lars Weitze <cd@kalkatraz.de>
Cc: Jeremy Zawodny <Jeremy@Zawodny.com>, linux-kernel@vger.kernel.org
Subject: Re: 100 Mbit on slow machine
Message-ID: <20020428161713.GA13998@thinkpad0.zawodny.com>
In-Reply-To: <20020427195609.0a397df9.cd@kalkatraz.de> <20020427221905.GA10112@thinkpad0.zawodny.com> <20020428152602.083e3b06.cd@kalkatraz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uptime: 09:16:01 up 20 days, 16:18,  6 users,  load average: 0.00, 0.00, 0.00
X-Os-Info: Linux thinkpad0 2.4.18 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2002 at 03:26:02PM +0200, Lars Weitze wrote:
> On Sat, 27 Apr 2002 15:19:05 -0700
> Jeremy Zawodny <Jeremy@Zawodny.com> wrote:
> 
> > Have you verified that the duplex settings are correct?  I've had
> > problems on more than one occasion with mismatched duplex on 100Mbit
> > cards (and switches).
> 
> Know the problem. It's running full duplex, but there is an other server
> an the same switch with the same network card making none of these
> problems. Anyway. I've put a 10 Mbit board into it now and moved the big
> harddisk to another PC.

If you feel like messing with it anymore, the only thing I can suggest
is that you try the newer tulip driver from sourceforge.  I recally
you mentioning a tulip driver in your original post.

I've had the newer tulip driver solve odd problems that the current
driver had.  YMMV, of course.

Jeremy
-- 
Jeremy D. Zawodny     |  Perl, Web, MySQL, Linux Magazine, Yahoo!
<Jeremy@Zawodny.com>  |  http://jeremy.zawodny.com/
