Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbTFPWJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTFPWJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:09:20 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:52790 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S264412AbTFPWJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:09:20 -0400
Date: Tue, 17 Jun 2003 00:22:45 +0200
Message-Id: <200306162222.h5GMMjtx004359@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released
In-Reply-To: <200306131453.h5DErX47015940@hera.kernel.org>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: 87 9F 39 9C F9 EE EA 7F  8F C9 58 6A D4 54 0E B9
X-Key-ID: 6DB9C699
User-Agent: tin/1.5.18-20030602 ("Darts") (UNIX) (Linux/2.4.21 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200306131453.h5DErX47015940@hera.kernel.org> you wrote:
> final:
> 
> - 2.4.21-rc8 was released as 2.4.21 with no changes.

Hello

I have still problem with big load when updatedb running on big ext3 home
area. :( I can't still do backups :(

System: 2x2.66GHz (with HyperThreading), 4GB RAM, aic79xx

 23:52:52  up 22:28, 18 users,  load average: 20.52, 10.65, 4.76
332 processes: 301 sleeping, 31 running, 0 zombie, 0 stopped
CPU0 states:   2.4% user  92.7% system    0.0% nice   0.0% iowait   4.7% idle
CPU1 states:   1.1% user  92.0% system    0.0% nice   0.0% iowait   6.7% idle
CPU2 states:   3.2% user  92.1% system    0.1% nice   0.0% iowait   4.4% idle
CPU3 states:   0.8% user  93.1% system    0.0% nice   0.0% iowait   6.0% idle
Mem:  4138892k av, 3990684k used,  148208k free,       0k shrd,  404432k buff
      1390652k active,            2212448k inactive
Swap: 4096360k av,   30116k used, 4066244k free                 2593732k cached


-- 
LT
