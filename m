Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132438AbRAXV2N>; Wed, 24 Jan 2001 16:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132345AbRAXV2D>; Wed, 24 Jan 2001 16:28:03 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64931 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129786AbRAXV16>;
	Wed, 24 Jan 2001 16:27:58 -0500
Importance: Normal
Subject: question about compiling the kernel
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFF0DFC748.A1DDEA9C-ON852569DE.00754674@somers.hqregion.ibm.com>
From: "Jie Zhou" <jiezhou@us.ibm.com>
Date: Wed, 24 Jan 2001 16:27:54 -0500
X-MIMETrack: Serialize by Router on D02ML231/02/M/IBM(Release 5.0.6 |December 14, 2000) at
 01/24/2001 04:27:56 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

 I got about 30 warning msgs like this during the process of "make
bzImage",   is it a fatal problem or not?
  "Warning: using '%eax' instead of '%ax' due to "l" suffix"

 2. after 'make bzImage', if I don't have any module to install, then I
don't need  to run either 'make modules' or 'make modules_install',
is this correct?

3. After I run the /sbin/lilo, it says the new kernel is added to the
system. HOwever when I restart the system and go into the labeled kernel
I choose, the system gets stucked after these two lines:
Loading kernel.......................
Uncompressing Linux...OK, booting the kernel.

Can you give me some advice on this. Thanks a lot for your kind reply..

Jie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
