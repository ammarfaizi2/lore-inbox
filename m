Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTDVITs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTDVITs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:19:48 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:4567 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263012AbTDVITr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 04:19:47 -0400
Message-ID: <3EA4FF4C.2030702@free.fr>
Date: Tue, 22 Apr 2003 10:37:32 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.21-rc1 : aic7xxx deadlock on boot on my machine 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just wants to point out on this list that since pre7 (or using 
pre4-acxx), I boot once out of two on my dual adaptec scsi machine.
The good news is that upgrading to more recent aic7xxx drivers fixes the 
problemas indeed the locking strategy has been changed... BTW, 2.5.68 
includes the new code also.

So I hope, it will be updated in rc2...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

