Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRA3FLu>; Tue, 30 Jan 2001 00:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRA3FLl>; Tue, 30 Jan 2001 00:11:41 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:34823 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129398AbRA3FL2>; Tue, 30 Jan 2001 00:11:28 -0500
From: mshiju@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        linux-tr@linuxtr.net
Message-ID: <CA2569E4.001BBA38.00@d73mta05.au.ibm.com>
Date: Tue, 30 Jan 2001 10:24:11 +0530
Subject: Info. regarding using IBM ISA turbo 16/4 tokenring adapter
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
            I am using IBM ISA turbo 16/4 tokenring adapter. This is what I
experienced in 2.4.0 kernel. On configuring the adapter using Lanaid tool ,
the default ROM address always falls within the video ROM area.. This was
causing the system to hang-up when XWindows was started and there was no
other way than to switch off the system and switch on again.  So I changed
the ROM area of the adapter using the Lanaid tool  which fall outside the
video ROM area.   Now I have no problem in using the XWindows. The default
interrupt is 3.  Have any one experienced this sort of problem



Thanks & Regards
Shiju


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
