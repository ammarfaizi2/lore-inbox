Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268813AbRHHTir>; Wed, 8 Aug 2001 15:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268909AbRHHTi0>; Wed, 8 Aug 2001 15:38:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64504 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268813AbRHHTiV>;
	Wed, 8 Aug 2001 15:38:21 -0400
Importance: Normal
Subject: Re: [RFC][PATCH] Scalable Scheduling
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF320F8ECC.3EB12A09-ON85256AA2.006BF096@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 8 Aug 2001 15:40:00 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/08/2001 03:38:25 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We did not modify the UP code at all. There will be NO effects (positive
nor negative) what so ever.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Victor Yodaiken <yodaiken@fsmlabs.com> on 08/08/2001 03:27:55 PM

To:   Mike Kravetz <mkravetz@sequent.com>
cc:   Linus Torvalds <torvalds@transmeta.com>, Hubertus
      Franke/Watson/IBM@IBMUS, linux-kernel@vger.kernel.org
Subject:  Re: [RFC][PATCH] Scalable Scheduling



On Wed, Aug 08, 2001 at 11:28:00AM -0700, Mike Kravetz wrote:
> One challenge will be maintaining the same level of performance
> for UP as in the current code.  The current code has #ifdefs to

How does the "current code" compare to the current Linux UP code?





