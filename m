Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSGIMoX>; Tue, 9 Jul 2002 08:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSGIMoW>; Tue, 9 Jul 2002 08:44:22 -0400
Received: from [199.128.236.1] ([199.128.236.1]:40457 "EHLO
	intranet.reeusda.gov") by vger.kernel.org with ESMTP
	id <S314835AbSGIMoV>; Tue, 9 Jul 2002 08:44:21 -0400
Message-ID: <630DA58AD01AD311B13A00C00D00E9BC05D2020B@CSREESSERVER>
From: "Martinez, Michael - CSREES/ISTM" <MMARTINEZ@intranet.reeusda.gov>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "Martinez, Michael - CSREES/ISTM" <MMARTINEZ@intranet.reeusda.gov>
Cc: linux-kernel@vger.kernel.org
Subject: RE: list of compiled in support
Date: Tue, 9 Jul 2002 08:47:37 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay. this would require a little C code right? is there a shell command
line tool I could use instead?

Michael Martinez
System Administrator (Contractor)
Information Systems and Technology Management
CSREES - United States Department of Agriculture
(202) 720-6223


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, July 09, 2002 6:20 AM
To: MMARTINEZ@intranet.reeusda.gov
Cc: linux-kernel@vger.kernel.org
Subject: Re: list of compiled in support


> How does one tell if a kernel has compiled in support for ipx?

Open an AF_IPX socket
