Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130295AbQKJOUJ>; Fri, 10 Nov 2000 09:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130666AbQKJOT7>; Fri, 10 Nov 2000 09:19:59 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:57100 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S130295AbQKJOTk>; Fri, 10 Nov 2000 09:19:40 -0500
Message-ID: <3A0C03FB.B188F966@holly-springs.nc.us>
Date: Fri, 10 Nov 2000 09:19:39 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [bug] kernel panic related to reiserfs, 2.4.0-test11-pre1 and 3.6.18
In-Reply-To: <3A0C030C.DE694934@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:

> With kdb, after the panic happens, I can hit 'sr s' then 'g', it will
> OOPS (process sendmail) then continue.  Without kdb, I am SOL and have
> to hit the power button.  sysrq won't react.

Debugger good.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
