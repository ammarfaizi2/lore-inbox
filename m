Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVDOSzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVDOSzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVDOSzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:55:22 -0400
Received: from smtp1.poczta.interia.pl ([217.74.65.44]:44590 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261876AbVDOSzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:55:17 -0400
Message-ID: <42600E12.8020304@interia.pl>
Date: Fri, 15 Apr 2005 20:55:14 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [SATA] status reports updated
References: <42600375.9080108@pobox.com>
In-Reply-To: <42600375.9080108@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: 483ccacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> My Linux SATA software/hardware status reports have just been updated. 
> To see where libata (SATA) support stands for a particular piece of 
> hardware, or a particular feature, go to
> 
>     http://linux.yyz.us/sata/

A nice thing in FAQ would be some info on problematic (blacklisted) SATA 
hardware that runs on Linux (vide "poor SATA performance under 2.6.11 
(with < 2.6.11 is OK)?" thread), like Silicon Image 311x controllers + 
some Seagate drives [1].


Tomek

[1] although my drive is blacklisted (Seagate barracuda - ST3200822AS), 
I "unblacklisted" it to get full performance - it's under heavy stress 
for 12th hour, and still no error.


------------------------------------------------------------------
Teraz na tapecie mamy najwiekszego z silaczy. 
Sciagnij >> http://link.interia.pl/f1873 <<

