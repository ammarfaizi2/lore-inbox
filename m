Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135327AbRAJLDd>; Wed, 10 Jan 2001 06:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135324AbRAJLDX>; Wed, 10 Jan 2001 06:03:23 -0500
Received: from f237.law9.hotmail.com ([64.4.9.237]:8462 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S135323AbRAJLDM>;
	Wed, 10 Jan 2001 06:03:12 -0500
X-Originating-IP: [130.233.220.23]
From: "M T" <hyponephele@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 umount problem
Date: Wed, 10 Jan 2001 11:03:06 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F237SHmFF4y07520vKE000060af@hotmail.com>
X-OriginalArrivalTime: 10 Jan 2001 11:03:06.0275 (UTC) FILETIME=[E8CD4730:01C07AF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running redhat 6.2 halt scripts and strange problem appears when 
shutting system down with kernel-2.4.0. I get message that "/ device is 
busy". I've updated util-linux (kill,mount,umount) according to 
documentation without any success. I've got no problems with 2.2.18.
Any ideas?

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
