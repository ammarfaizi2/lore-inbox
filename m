Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272266AbRH3PXI>; Thu, 30 Aug 2001 11:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272269AbRH3PW6>; Thu, 30 Aug 2001 11:22:58 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:52242 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S272266AbRH3PWo>;
	Thu, 30 Aug 2001 11:22:44 -0400
Message-ID: <3B8E5A50.3040703@nyc.rr.com>
Date: Thu, 30 Aug 2001 11:22:56 -0400
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010802
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ATAPI Floppy Problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error on reboot...

Aug 30 02:31:17 boolean kernel: ide-floppy: hdc: I/O error, pc = 5a, key 
=  5, asc = 24, ascq =  0

I have a ZIP 100, and am currently using ide-floppy driver 0.97 
(included with linux 2.4.9).

Suggestions?

