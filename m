Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbTGEPsx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 11:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266380AbTGEPsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 11:48:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24254 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266376AbTGEPsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 11:48:47 -0400
Message-ID: <3F06F6BA.6060200@pobox.com>
Date: Sat, 05 Jul 2003 12:03:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANN] 2.4.x snapshots started
References: <3F06D2ED.8080904@pobox.com> <20030705154032.GA9428@alpha.home.local>
In-Reply-To: <20030705154032.GA9428@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sat, Jul 05, 2003 at 09:30:21AM -0400, Jeff Garzik wrote:
> 
>>Just like 2.5.x, nightly snapshots of Marcelo's latest 2.4.x BK 
>>repository are being posted on kernel.org:
>>
>>ftp://ftp.??.kernel.org/pub/linux/kernel/v2.4/snapshots/
>>
>>I created the first snapshot midday as a test, and the standard cron job 
>>created a second one, so the current release is 2.4.21-bk2.
> 
> 
> Jeff, in -bk2, only EXTRAVERSION got changed in Makefile, so the complete
> name is now 2.4.22-bk2. This is because the base kernel was 2.4.22-pre2.

hrm, good point.  Fixing...

	Jeff



