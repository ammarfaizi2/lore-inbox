Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313641AbSDJTaT>; Wed, 10 Apr 2002 15:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313644AbSDJTaS>; Wed, 10 Apr 2002 15:30:18 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:47554 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313641AbSDJTaN>; Wed, 10 Apr 2002 15:30:13 -0400
Subject: Re: [PATCH] Futex Generalization Patch
To: frankeh@watson.ibm.com
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        pwaechtler@loewe-Komp.de, Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF0676911E.A8260761-ON85256B97.006AB10C@raleigh.ibm.com>
From: "Bill Abt" <babt@us.ibm.com>
Date: Wed, 10 Apr 2002 15:30:33 -0400
X-MIMETrack: Serialize by Router on D04NM202/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/10/2002 03:30:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2002 at 02:10:59 PM AST, Hubertus Franke <frankeh@watson.ibm.com>
wrote:
>
> So you are OK with having only poll  or  select.  That seems odd.
> It seems you still need SIGIO on your fd to get the async notification.
>

Duh...  You're right.  I forgot about that...

Regards,
      Bill Abt
      Senior Software Engineer
      Next Generation POSIX Threading for Linux
      IBM Cambridge, MA, USA 02142
      Ext: +(00)1 617-693-1591
      T/L: 693-1591 (M/W/F)
      T/L: 253-9938 (T/Th/Eves.)
      Cell: +(00)1 617-803-7514
      babt@us.ibm.com or abt@us.ibm.com
      http://oss.software.ibm.com/developerworks/opensource/pthreads

