Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTC0Lx4>; Thu, 27 Mar 2003 06:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbTC0Lx4>; Thu, 27 Mar 2003 06:53:56 -0500
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:29065 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261934AbTC0Lxz>; Thu, 27 Mar 2003 06:53:55 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] s390 update (3/9): listing & kerntypes.
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF78A11791.550D90BA-ONC1256CF6.00419756@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Thu, 27 Mar 2003 13:02:37 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 27/03/2003 13:04:12
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No.  The Kerntypes patch makes lots of sense even without lkcd.  Once
> again I'm all in favour of adding this patch, but adding such a generic
> facility in architecture depend code is a bad idea.

I still think that due to the fact that each architecture has it own
special set of includes that this is not really a generic facility.
But anyhow if you want to do this via the lkcd patch them be it.

blue skies,
   Martin


