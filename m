Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316042AbSENUaJ>; Tue, 14 May 2002 16:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316041AbSENUaI>; Tue, 14 May 2002 16:30:08 -0400
Received: from uucp.cistron.nl ([195.64.68.38]:37894 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S316040AbSENUaH>;
	Tue, 14 May 2002 16:30:07 -0400
From: Rene Blokland <reneb@orac.aais.org>
Subject: Foloppy always read only after 2.5.12?
Date: Tue, 14 May 2002 22:20:23 +0200
Organization: Cistron
Message-ID: <slrnae2sc7.dhe.reneb@orac.aais.org>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1021408206 12840 195.64.94.30 (14 May 2002 20:30:06 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When  try to run lilo with a kernel after 2.5.12 to a floppy i get:
Fatal: open /dev/fd0: Read-only file system
Im runnig on a x86 platform with with a AMD K6 
to me it seems at an enduser error because knowbody has this problem reported
this or is it realy a bug.
The floppy drive is detected :
May 14 07:09:07 orac kernel: Floppy drive(s): fd0 is 1.44M
May 14 07:09:07 orac kernel: FDC 0 is a post-1991 82077


Groeten / Regards, Rene J. Blokland

