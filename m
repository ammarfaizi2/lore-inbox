Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273696AbRIQUi3>; Mon, 17 Sep 2001 16:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273695AbRIQUiT>; Mon, 17 Sep 2001 16:38:19 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:2318 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S273694AbRIQUiK>; Mon, 17 Sep 2001 16:38:10 -0400
Message-ID: <3BA65EA9.E4BD38A1@opersys.com>
Date: Mon, 17 Sep 2001 16:35:53 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.5-TRACE i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: LTT-Dev <ltt-dev@shafik.org>, LTT-Announce <ltt-announce@shafik.org>,
        LTT <ltt@shafik.org>, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] LTT 0.9.5pre2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a new version of LTT out there, 0.9.5pre2.

The most important addition to it is the ability to link to
the event database in order to manipulate traces programmatically
without the visualizer. This is done through a dynamic library
called LibLTT which provides the necessary API to load, analyze
and browse a trace.

Also added is the capability to log custom formatting information
regarding custom events. This information can be retrieved from
the trace using LibLTT and, if needed, modified.

For a more complete rundown of the additions to 0.9.5pre2 take
a look at the news section of the web site.

LTT 0.9.5pre2 can be found here:
ftp://ftp.opersys.com/pub/LTT/TraceToolkit-0.9.5pre2.tgz

P.S.: Unfortunately, I haven't had the time to fix RTAI support
in LTT. However, since the trace statements are now part of
the permanent RTAI CVS, this support should be easier to
provide in the future once the next version of LTT supporting
RTAI is out.

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
