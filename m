Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310441AbSCTBBS>; Tue, 19 Mar 2002 20:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310458AbSCTBBI>; Tue, 19 Mar 2002 20:01:08 -0500
Received: from marcy.nas.nasa.gov ([129.99.113.17]:53224 "EHLO
	marcy.nas.nasa.gov") by vger.kernel.org with ESMTP
	id <S310441AbSCTBAr>; Tue, 19 Mar 2002 20:00:47 -0500
Message-Id: <200203200100.RAA11124@marcy.nas.nasa.gov>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: dnotify defines not in headers
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Mar 2002 17:00:41 -0800
From: Brian S Queen <bqueen@nas.nasa.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I get my dnotify #defines which I put in <linux/fcntl.h> into <fcntl.h>
?  I have already recompiled glibc and such as suggested.  I am sure for 
dnotify to be useful the defines must be added to the standard headers.

My kernel builds correctly as does glibc using my new headers (using the 
--with-headers= option).  In fact I remade all the standard headers from 
scratch, wiping out the old ones using the special --with-headers option. 
Still my defines are not being merged into the standard header.

Brian McQueen
NAS Division
NASA/Ames

