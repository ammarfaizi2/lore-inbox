Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262934AbRFFMpq>; Wed, 6 Jun 2001 08:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262923AbRFFMph>; Wed, 6 Jun 2001 08:45:37 -0400
Received: from iproxy2.ericsson.dk ([130.228.248.99]:30883 "EHLO
	iproxy2.ericsson.dk") by vger.kernel.org with ESMTP
	id <S262856AbRFFMpU>; Wed, 6 Jun 2001 08:45:20 -0400
Message-ID: <3B1E24ED.544FA1D7@fabbione.net>
Date: Wed, 06 Jun 2001 14:41:17 +0200
From: Fabbione <fabbione@fabbione.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OFFTOPIC] lmc_utils + 2.4.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	I was testing the kernel support for the LMC1200 interface (E1/T1)
and like specified in the help menu a user land tool is needed to
configure
the interface. But during the compilation time is reporting this error

/usr/include/linux/timer.h:17: field `list' has incomplete type

and compilation fails.

I'm using Debian unstable latest update, kernel 2.4.5 and lmc utils
1.34.15
Does someone have any idea on how to fix it?????

I can provide anykind of info if needed.

Thanks a lot
Best Regards
Fabio
