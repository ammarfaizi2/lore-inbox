Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135446AbRDMIsd>; Fri, 13 Apr 2001 04:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135445AbRDMIsY>; Fri, 13 Apr 2001 04:48:24 -0400
Received: from binky.de.uu.net ([192.76.144.28]:58623 "EHLO binky.de.uu.net")
	by vger.kernel.org with ESMTP id <S135446AbRDMIsG>;
	Fri, 13 Apr 2001 04:48:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Detlev Offenbach <detlev@offenbach.fs.uunet.de>
To: linux-kernel@vger.kernel.org
Subject: MO-Drive under 2.4.3
Date: Fri, 13 Apr 2001 10:47:50 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041310475000.02120@majestix>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi out there,

I have a problem using my MO-Drive under kernel 2.4.3. I have several disks 
formated with a VFAT filesystem. Under kernel 2.2.19 everything works fine. 
Under kernel 2.4.3 I cannot write anything to the disk without hanging the 
complete system so that I have to use the reset button. For disks with an 
ext2 filesystem it works okay.

Regards
Detlev
-- 
Detlev Offenbach
detlev@offenbach.fs.uunet.de
