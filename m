Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271746AbTHDOAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271749AbTHDOAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:00:34 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:145 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S271746AbTHDOAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:00:33 -0400
Message-ID: <3F2E66FE.3050703@physik.uni-wuerzburg.de>
Date: Mon, 04 Aug 2003 16:00:30 +0200
From: Tobias Muck <muck@physik.uni-wuerzburg.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: System locks up hard when i delete a file while burning a DVD-R
 (seems reiserfs related)
References: <g8G5.v2.13@gated-at.bofh.it> <g996.Tx.13@gated-at.bofh.it>
In-Reply-To: <g996.Tx.13@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > The same happend to me on friday:
 > while burning a DVD-RW and deleting the source files of the image, the
 > system locked up hard (SuSE Linux 8.2, Kernel 2.4.20-64GB-SMP,
 > reiserfs, pentium 4 with HT).

addendum
This problem seems only to occur on smp systems.

Tobias




