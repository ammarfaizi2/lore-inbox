Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129291AbRAaCxw>; Tue, 30 Jan 2001 21:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129399AbRAaCxc>; Tue, 30 Jan 2001 21:53:32 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:57664 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129291AbRAaCxX>; Tue, 30 Jan 2001 21:53:23 -0500
Message-ID: <3A777E1A.8F124207@linux.com>
Date: Tue, 30 Jan 2001 18:53:14 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.x and SMP fails to compile (`current' undefined)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A person just brought up a problem in #kernelnewbies, building an SMP
kernel doesn't work very well, current is undefined.  I don't have more
time to debug it but I'll strip the config and put it up at
http://stuph.org/smp-config

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
