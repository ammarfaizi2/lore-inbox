Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVF2RMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVF2RMQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVF2RIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:08:10 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:17643 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262634AbVF2RHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:07:37 -0400
Date: Wed, 29 Jun 2005 10:07:26 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: ismail@kde.org.tr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc1 problems
Message-Id: <20050629100726.36bf4046.rdunlap@xenotime.net>
In-Reply-To: <200506291934.32909.ismail@kde.org.tr>
References: <200506291934.32909.ismail@kde.org.tr>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005 19:34:32 +0300 Ismail Donmez wrote:

| Hi all,
| 
| I upgraded to 2.6.13-rc1 and kjournald now takes 100% CPU and I see worrying 
| problems in syslog :
| 
| Jun 29 19:15:05 localhost kernel: Badness in blk_remove_plug at 
| drivers/block/ll_rw_blk.c:1424

see http://marc.theaimsgroup.com/?l=linux-kernel&m=112005781612321&w=2
for patch.


---
~Randy
