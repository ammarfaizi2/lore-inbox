Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272712AbRITBgS>; Wed, 19 Sep 2001 21:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274294AbRITBgI>; Wed, 19 Sep 2001 21:36:08 -0400
Received: from f177.law7.hotmail.com ([216.33.237.177]:9993 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S272712AbRITBfz>;
	Wed, 19 Sep 2001 21:35:55 -0400
X-Originating-IP: [211.210.69.171]
From: "Tobin Park" <shinywind@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Network buffer allocation
Date: Thu, 20 Sep 2001 01:36:14 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F177WQejqpRI7aIrq0400001a8c@hotmail.com>
X-OriginalArrivalTime: 20 Sep 2001 01:36:14.0996 (UTC) FILETIME=[A302B540:01C14174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am a newbie of linux kernel and studying network kernel source.
when network device driver receives packet and allocates buffer,
what is the default size of allocation?
and is there any reallocation happened when upper layer(ip/tcp) manipulates
buffer which was allocated by device driver?

Thank you.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

