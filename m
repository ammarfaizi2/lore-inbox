Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289551AbSAJRKr>; Thu, 10 Jan 2002 12:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289552AbSAJRKi>; Thu, 10 Jan 2002 12:10:38 -0500
Received: from vieo.com ([216.30.79.131]:54532 "EHLO vieo.com")
	by vger.kernel.org with ESMTP id <S289551AbSAJRKa>;
	Thu, 10 Jan 2002 12:10:30 -0500
Message-ID: <3C3DCAFD.D82DCB05@vieo.com>
Date: Thu, 10 Jan 2002 11:10:21 -0600
From: Joe Golio <golio@vieo.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB-SMP i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, golio@vieo.com
Subject: Question about /usr/include/netdevice.h
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-scanner: scanned by Inflex 0.1.5c+ on vieo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

	I am new at this so bare with me...

	Inside /usr/include/linux/netdevice.h, there is a 
	#define for MAX_ADDR_LEN which is currently set to
	a value of "7" in 2.4. I am working on an implementation
	where the hardware address of the media needs be larger
	than 7 bytes. What is the process by which I would have
	to go through to get this value changed to something larger
	than 7 bytes, if I so desired ?

Thanks,

Joe Golio

