Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277552AbRJ1Aal>; Sat, 27 Oct 2001 20:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277531AbRJ1Aac>; Sat, 27 Oct 2001 20:30:32 -0400
Received: from cogito.cam.org ([198.168.100.2]:24594 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S277083AbRJ1AaK>;
	Sat, 27 Oct 2001 20:30:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: 2.4.14pre3 observations.
Date: Sat, 27 Oct 2001 20:26:18 -0400
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011028002618.B1A99AA9F@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My dbench numbers are better here.  2.4.13 got 12.5-14 MB/s in 
8:43 mins, 2.4.14-pre3 is getting 16-17 MB/s in 6:29 mins on the 
same box.  

Also nice is that xmm2 reports the kernel using lesss
memory,  xmm2 reports on swapped, free, inactive, active
and kernel memory.  In previous release about 50% of memory
was reported as kernel, in pre4 its about 10%... (what changed?).

Luck,

Ed Tomlinson
