Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265574AbRF1HAO>; Thu, 28 Jun 2001 03:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265575AbRF1HAE>; Thu, 28 Jun 2001 03:00:04 -0400
Received: from mail.muc.eurocyber.net ([195.143.108.5]:40386 "EHLO
	mail.muc.eurocyber.net") by vger.kernel.org with ESMTP
	id <S265574AbRF1G7y>; Thu, 28 Jun 2001 02:59:54 -0400
Message-ID: <3B3AD5DC.EE9A2B82@TeraPort.de>
Date: Thu, 28 Jun 2001 08:59:40 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac19 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <Pine.LNX.4.33L.0106271512570.23373-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Wed, 27 Jun 2001, Martin Knoblauch wrote:
> 
> >  I do not care much whether the cache is using 99% of the systems memory
> > or 50%. As long as there is free memory, using it for cache is great. I
> > care a lot if the cache takes down interactivity, because it pushes out
> > processes that it thinks idle, but that I need in 5 seconds. The caches
> > pressure against processes
> 
> Too bad that processes are in general cached INSIDE the cache.
> 
> You'll have to write a new balancing story now ;)
> 

 maybe that is part of "the answer" :-)

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
