Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315535AbSEQJym>; Fri, 17 May 2002 05:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315537AbSEQJyl>; Fri, 17 May 2002 05:54:41 -0400
Received: from B57a0.pppool.de ([213.7.87.160]:14349 "HELO Nicole.fhm.edu")
	by vger.kernel.org with SMTP id <S315535AbSEQJyk>;
	Fri, 17 May 2002 05:54:40 -0400
Subject: Tell the harddrive to map badblocks?
From: Daniel Egger <degger@fhm.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 17 May 2002 11:50:54 +0200
Message-Id: <1021629054.15079.9.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hija,

how do I tell the harddrive to do it's badblock mapping in hardware
if hdparm -D1 doesn't work and ext3 keeps on accessing the cracked
sectors even with the corrupted pieces being in the badblocks list
of the filesystem?

-- 
Servus,
       Daniel

