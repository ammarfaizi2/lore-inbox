Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281019AbRKCTca>; Sat, 3 Nov 2001 14:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281024AbRKCTcT>; Sat, 3 Nov 2001 14:32:19 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:50322 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281019AbRKCTcN>;
	Sat, 3 Nov 2001 14:32:13 -0500
Message-ID: <3BE4460F.97FAD9CE@pobox.com>
Date: Sat, 03 Nov 2001 11:31:27 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Thomas Lussnig <tlussnig@bewegungsmelder.de>,
        linux-kernel@vger.kernel.org,
        khttpd mailing list <khttpd-users@zgp.org>,
        Tux mailing list <tux-list@redhat.com>
Subject: Re: [khttpd-users] khttpd vs tux
In-Reply-To: <Pine.LNX.4.30.0111032014580.9446-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

> I read something by Linus about linux scalability, and I beleive he said
> that 'linux [2.4] scales good up to 4 cpus, but not that good futher on
> [to 8?]'. Can anyone fill in the holes here?

Nobody scales better 1-4 CPUs, as indicated
by specweb99 - at 8 CPUs linux is OK, but not
as dominating....

When the high end specialists from IBM etc
can send in patches that enhance high end
performance without hurting the low end case
the numbers on 8-32 CPUs should really start
to shine. (There has been progress on that
front seen on lkml)

cu

jjs




