Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264594AbSIVWvE>; Sun, 22 Sep 2002 18:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264596AbSIVWvD>; Sun, 22 Sep 2002 18:51:03 -0400
Received: from nameservices.net ([208.234.25.16]:57588 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264594AbSIVWu2>;
	Sun, 22 Sep 2002 18:50:28 -0400
Message-ID: <3D8E4B1D.48F7487D@opersys.com>
Date: Sun, 22 Sep 2002 18:58:37 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: bob <bob@watson.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>, okrieg@us.ibm.com, trz@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
References: <15758.12948.103681.852724@k42.watson.ibm.com>
		<Pine.LNX.4.44.0209222333470.19919-100000@localhost.localdomain> <15758.14124.935684.460733@k42.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bob wrote:
> The intent is to split LTT, get the infrastructure into the kernel, have
> the trace points as patches.

I think there's a bare minimum set that is required for the day-to-day uses
I detailed earlier, but there is certainly ample space for providing extra
non-essential trace points as separate patches.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
