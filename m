Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313593AbSDPEUl>; Tue, 16 Apr 2002 00:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313595AbSDPEUk>; Tue, 16 Apr 2002 00:20:40 -0400
Received: from huey.topnz.ac.nz ([202.37.12.2]:17129 "EHLO huey.topnz.ac.nz")
	by vger.kernel.org with ESMTP id <S313593AbSDPEUk> convert rfc822-to-8bit;
	Tue, 16 Apr 2002 00:20:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: GCC 3.0.x (was  Re: [PATCH])
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Tue, 16 Apr 2002 16:12:08 +1200
Message-ID: <4B2093FFC31B7A45862B62A376EA717601394011@mickey.topnz.ac.nz>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-kernel] Re: [PATCH]
Thread-Index: AcHk+1gyn+pSWRhgQculNW7JD/x9dgAAMuCQ
From: "Sartorelli, Kevin" <SarKev@topnz.ac.nz>
To: <linux-kernel@vger.kernel.org>
Cc: <forming@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone else had problems with GCC 3.0.x and the 2.5.x kernels?  I have no problems compiling the kernel, and it boots.  BUT some time soon after, it looks like the schedular dies - any program I try to run never go anywhere and the machine stops responding.  If this is a known problem with GCC 3.0.x I'll shut up until it's resolved, but it would be nice to know if it's just me :-(

Cheers
Kevin

-----Original Message-----
From: Josh McKinney [mailto:forming@comcast.net]
Well it compiled fine this time, but it seems to have problems with gcc-3.0.4 I am using to compile kernels.  This gcc has been fine for all other uses, but it must be something with this particular build because gcc-2.95.4 works without a problem.  Anyways, here is the oops report if it may interest you.
