Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281283AbRKTTEO>; Tue, 20 Nov 2001 14:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281225AbRKTTCz>; Tue, 20 Nov 2001 14:02:55 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:1408 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281235AbRKTTCs>; Tue, 20 Nov 2001 14:02:48 -0500
Date: Tue, 20 Nov 2001 13:05:35 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: [PATCH] NetWare File System (NWFS) 24.15-pre7 posted
Message-ID: <20011120130535.A691@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A patch that integrates the NetWare File System (NWFS) for Linux
2.4.15-pre7 has been posted at 

ftp.timpanogas.org:/nwfs/nwfs-2.4.15-pre7-1.bz2
ftp.utah-nac.org:/nwfs/nwfs-2.4.15-pre7-1.bz2

I noticed during the test build after applying the pre7 patch
that one of the include files in linux/sem.h seemed to complain
about "unsigned" being misspelled as "unsgined" or something like
this.  

Jeff

