Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbRFMVad>; Wed, 13 Jun 2001 17:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263167AbRFMVaX>; Wed, 13 Jun 2001 17:30:23 -0400
Received: from f5.law4.hotmail.com ([216.33.149.5]:58375 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262702AbRFMVaN>;
	Wed, 13 Jun 2001 17:30:13 -0400
X-Originating-IP: [208.216.180.101]
From: "Jason Murphy" <jasonthomasmurphy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19: eepro100 and cmd_wait issues
Date: Wed, 13 Jun 2001 21:30:07 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F5jkyqU7a0xtAEHLB8T0000b185@hotmail.com>
X-OriginalArrivalTime: 13 Jun 2001 21:30:07.0052 (UTC) FILETIME=[0425C8C0:01C0F450]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would suggest that you use the e100 driver instead of the eepro100 driver.

We switched to the e100 driver from the eepro100 driver, and a number of our 
FTP, NFS and rsync (IE: High bandwidth apps) problems went away.

Our system are mostly 6 Proc boxes with 4 gigs of memeory.

--
Jason Murphy

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

