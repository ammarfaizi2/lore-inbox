Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312687AbSDXWKK>; Wed, 24 Apr 2002 18:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312690AbSDXWKJ>; Wed, 24 Apr 2002 18:10:09 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:17166 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S312687AbSDXWKI>; Wed, 24 Apr 2002 18:10:08 -0400
Message-ID: <3CC72CDC.CF80C0C6@opersys.com>
Date: Wed, 24 Apr 2002 18:08:28 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Linux Trace Toolkit 0.9.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


LTT 0.9.5 has now been released.

A very large number of enhancements have been added since 0.9.4. This
is a summary:
o S/390 port 
o SuperH port 
o MIPS port 
o Cross-platform trace reading capabilities 
o Updated RTAI support 
o User-space events (LibUserTrace) 
o Binary traces accessible through user-space library (LibLTT) 
o Visualizer enhancements 
o Dynamic modification of trace masks 
o Autoconf/autobuild build system integration 

For the full detail of the additions, see the news section of the
project's website.

Since LTT is close to 3 years old, it has become a large body of
software. To facilitate easy understanding of what LTT does and what
it doesn't, I've added a "features" description on the project's
front page: http://www.opersys.com/LTT/index.html#features

The list of events traced LTT had been previously documented in
some of the articles I presented about the tool. In order to
facilitate access, I've added an online version of the events
list: http://www.opersys.com/LTT/trace-points.html

As I said earlier, a 2.5.x patch is available and LTT is ready to
be integrated into the 2.5 series.

LTT's website is: http://www.opersys.com/LTT

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
