Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271718AbRHQV3D>; Fri, 17 Aug 2001 17:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271719AbRHQV2x>; Fri, 17 Aug 2001 17:28:53 -0400
Received: from [24.93.35.41] ([24.93.35.41]:64645 "EHLO sm14.texas.rr.com")
	by vger.kernel.org with ESMTP id <S271718AbRHQV2g>;
	Fri, 17 Aug 2001 17:28:36 -0400
Date: Fri, 17 Aug 2001 16:31:27 -0500 (CDT)
From: Jeff Meininger <jeffm@boxybutgood.com>
X-X-Sender: <jeffm@mangonel.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: 'detect' floppy hardware from userland?  ioctl?
Message-ID: <Pine.LNX.4.33.0108171628470.550-100000@mangonel.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm writing an app that needs to know what floppy drives are connected to
the system.  Right now, I'm parsing the output of 'dmesg', but 'dmesg' can
fill up so that the part where floppy drives are listed is no longer
available.  Is there an ioctl or some other interface for discovering fd0,
fd1, etc?

Thanks.
BTW, I'm not a list member, please Cc: my address!
-Jeff M

