Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWDOSiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWDOSiq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 14:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWDOSiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 14:38:46 -0400
Received: from w3.zipcon.net ([209.221.136.4]:15022 "HELO w3.zipcon.net")
	by vger.kernel.org with SMTP id S1030301AbWDOSip convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 14:38:45 -0400
From: Bill Waddington <william.waddington@beezmo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: SATA Conflict with PATA DMA
Date: Sat, 15 Apr 2006 11:38:25 -0700
Message-ID: <p9f2425uijetlpcq49m08cto9la898l80f@4ax.com>
References: <fa.m9JwGQvLBixssS4UodPQfih6Ygk@ifi.uio.no> <87odz2kc0k.fsf@esben-stien.name> <fa.foo0W8w4UdiDztK9eBiA9awyAi8@ifi.uio.no>
In-Reply-To: <fa.foo0W8w4UdiDztK9eBiA9awyAi8@ifi.uio.no>
X-Mailer: Forte Agent 3.3/32.846
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2006 16:42:22 UTC, in fa.linux.kernel you wrote:

>Esben Stien wrote:
>> I'm having problems enabling DMA for my PATA HD.
>> 
>> hdparm -d1 /dev/hdb reports: 
>> HDIO_SET_DMA failed: Operation not permitted
>> 
>> Of course, I'm super user. Nothing is printed in dmesg. 
>> 
>> I'm on linux-2.6.16 and motherboard is Fujitsu Siemens D1561 with an
>> ICH5. I also have a SATA hd in the computer and this only happens when
>> the SATA hd is there. If I remove the SATA HD, then I can enable DMA
>> for the PATA hd.
>
>Disabled combined mode in BIOS.

If only that was possible on my fscking T43.  *sigh*

Bill
-- 
William D Waddington
william.waddington@beezmo.com
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch

