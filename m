Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135241AbRDZJ3D>; Thu, 26 Apr 2001 05:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135242AbRDZJ2w>; Thu, 26 Apr 2001 05:28:52 -0400
Received: from samar.sasken.com ([164.164.56.2]:61877 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S135241AbRDZJ2h>;
	Thu, 26 Apr 2001 05:28:37 -0400
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-b.sasi.com
From: Deepika Kakrania <deepika@sasken.com>
Subject: Where to put initialization related stuff???
Date: Thu, 26 Apr 2001 14:50:54 +0530
Message-ID: <Pine.GSO.4.30.0104261442080.25453-100000@suns3.sasi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Trace: ncc-c.sasi.com 988276855 21235 10.0.36.3 (26 Apr 2001 09:20:55 GMT)
X-Complaints-To: usenet@sasi.com
Xref: ncc-b.sasi.com maillist.linux-kernel:148088
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

  I want to initialise some global variables in kernel as soon as kernel
comes up.

Could anyone tell me where can this be done? Is it correct to put such
initialisations in init() function of file /init/main.c

thanks & regards,
Deepika

--------------------------------------------------------------------------------

 Deepika Kakrania
 Sasken Communication Technologies Limited

 Phone No:(080) 5276100/108 Extn:4467
                5289906 (res)
 Email: deepika@sasi.com

