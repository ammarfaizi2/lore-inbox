Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293006AbSB1JAg>; Thu, 28 Feb 2002 04:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293195AbSB1I60>; Thu, 28 Feb 2002 03:58:26 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:57362 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S293202AbSB1I6Q>;
	Thu, 28 Feb 2002 03:58:16 -0500
Message-Id: <200202280858.BAA103851@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: update with 2.4.19-pre1-ac2 Re: Possible IDE related crash on 2.4.18-rc4?
In-Reply-To: Jeff Lessem's message of Wed, 27 Feb 2002 14:35:14 MST.
In-Reply-To: <20020227200127.58784.qmail@web21301.mail.yahoo.com> <200202272135.OAA52607@ibg.colorado.edu> 
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 8063
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2002 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Thu, 28 Feb 2002 01:58:01 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.4.19-pre1-ac2 and I still get the disk hang.  Fortunately
with this kernel the machine did not hang, but all reading and writing
from the disk stopped.  I could still use sysrq, but I am not sure
what information would be useful to gather.

What utilities would be useful to keep on a tmpfs filesystem, for
diagnostic use when the disk freezes?

--
Jeff Lessem.
