Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbTIQNfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 09:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbTIQNfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 09:35:22 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:6671 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262754AbTIQNfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 09:35:18 -0400
From: Michael Frank <mhf@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.24-pre4 - nice VM
Date: Wed, 17 Sep 2003 21:32:23 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309172132.23461.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Built with gcc version 2.95.3 20010315 (release) 

Use it since Monday on a 600Mhz TM5600 with 256MB RAM
using S3 Savage, X4.3, KDE 3.1x

The -aa VM is a realy big improvement in terms of resonsiveness. 

My gut tells it is about as responsive as 2.6 and that is 
slightly faster than 2.6 on average.

The only rough adges I saw:

 - Once a day one or two desktop icons don't get repainted 

 - Once a day the odd app may have closed (not crashed) without me asking it

 - Had one hang hang of kppp after being returned to forgroun,d which was 
   cured by killing and restarting it. kppp has never hanged with other 2.4,
   2.5 or 2.6 kernels

Any stress tests, hints on what to look for are welcome

Regards
Michael


