Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292657AbSCILRq>; Sat, 9 Mar 2002 06:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292652AbSCILRg>; Sat, 9 Mar 2002 06:17:36 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:24326 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S292657AbSCILRX>; Sat, 9 Mar 2002 06:17:23 -0500
Message-ID: <3C89EF33.B0CB77BD@linux-m68k.org>
Date: Sat, 09 Mar 2002 12:17:07 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: Rik van Riel <riel@conectiva.com.br>,
        "Jonathan A. George" <JGeorge@greshamstorage.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com> <20020307170334.D5423@host110.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Cort Dougan wrote:

> Only doing a given merge once is great.  That's a big time-saver over the
> long term.

Could someone explain me, how this "merge once" works? How is this
different from cvs? I mean, cvs is capable of doing merges, if new
changes are not at the same position.

bye, Roman
