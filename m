Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbSJUFw3>; Mon, 21 Oct 2002 01:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264742AbSJUFw3>; Mon, 21 Oct 2002 01:52:29 -0400
Received: from nameservices.net ([208.234.25.16]:42955 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S264739AbSJUFw2>;
	Mon, 21 Oct 2002 01:52:28 -0400
Message-ID: <3DB398C4.6DB5CB0B@opersys.com>
Date: Mon, 21 Oct 2002 02:03:48 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: landley@trommello.org
CC: linux-kernel@vger.kernel.org, boissiere@nl.linux.org
Subject: Re: Crunch time -- Final merge candidates for 3.0 (the list).
References: <200210201849.23667.landley@trommello.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rob Landley wrote:
> o Ready - Build option for Linux Trace Toolkit (LTT) (Karim Yaghmour)
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html

LTT has seen a number of changes since the posting above. Mainly,
we've followed the recommendations of quite a few folks from the LKML.
Here are some highlights summarizing the changes:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103491640202541&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103423004321305&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103247532007850&w=2

The latest patch is available here:
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021019-2.2.bz2
Use this patch with version 0.9.6pre2 of the user tools:
http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
