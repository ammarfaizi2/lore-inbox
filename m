Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312799AbSDOOvD>; Mon, 15 Apr 2002 10:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312803AbSDOOvC>; Mon, 15 Apr 2002 10:51:02 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:992 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312799AbSDOOvB>;
	Mon, 15 Apr 2002 10:51:01 -0400
Subject: Re: [PATCH] Futex Generalization Patch
To: frankeh@watson.ibm.com
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF24E0B753.2B92A422-ON85256B9C.00512368@raleigh.ibm.com>
From: "Bill Abt" <babt@us.ibm.com>
Date: Mon, 15 Apr 2002 10:49:13 -0400
X-MIMETrack: Serialize by Router on D04NM202/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/15/2002 10:49:15 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dealing with the realtime signal is not a problem.  Also, saving the extra
system call is *BIG* bonus.


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

