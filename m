Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314709AbSEFUVF>; Mon, 6 May 2002 16:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314842AbSEFUVE>; Mon, 6 May 2002 16:21:04 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:12848 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S314709AbSEFUVD>; Mon, 6 May 2002 16:21:03 -0400
Subject: Linux NUMA on M68k?
From: Mike Panetta <ahuitzot@mindspring.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 May 2002 12:19:24 -0700
Message-Id: <1020712765.14641.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Has anyone implimented NUMA on any M68K based systems?  The one I
specificly have in mind is a VME chassis with multiple MVME16x boards in
it, each of which are capable of sharing their main memory over the VME
bus.  Is this a configuration that makes sense for NUMA? What work would
be required to add NUMA support to the M68k kernel in this situation?

Thanks,
Mike

PS: I am not on this list so please CC me.

