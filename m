Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRHYQ23>; Sat, 25 Aug 2001 12:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269651AbRHYQ2U>; Sat, 25 Aug 2001 12:28:20 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:4784 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S269632AbRHYQ2I>;
	Sat, 25 Aug 2001 12:28:08 -0400
Date: Sat, 25 Aug 2001 18:28:15 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <20010825182815.K773@cerebro.laendle>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010825154325Z16125-32383+1325@humbolt.nl.linux.org> <Pine.LNX.4.33L.0108251249510.5646-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0108251249510.5646-100000@imladris.rielhome.conectiva>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 12:50:51PM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> Remember NL.linux.org a few weeks back, where a difference of
> 10 FTP users more or less was the difference between a system
> load of 3 and a system load of 250 ?  ;)

OTOH, servers the use a single process or thread per connection are
destined to fail under load ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
