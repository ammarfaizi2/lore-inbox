Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268353AbTBSLHd>; Wed, 19 Feb 2003 06:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268356AbTBSLHd>; Wed, 19 Feb 2003 06:07:33 -0500
Received: from mail.interware.hu ([195.70.32.130]:29332 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP
	id <S268353AbTBSLHc>; Wed, 19 Feb 2003 06:07:32 -0500
Subject: Re: Linux v2.5.62
From: Hirling Endre <endre@interware.hu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E536237.8010502@blue-labs.org>
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
	 <3E536237.8010502@blue-labs.org>
Content-Type: text/plain
Organization: 
Message-Id: <1045653449.26291.39.camel@dusk.interware.hu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Feb 2003 12:17:29 +0100
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *18lSED-0005Hj-00*UI1I9UiuAkY* (Interware Inc.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 11:53, David Ford wrote:
> 2.5.60+ is rather unstable for me on an Athlon CPU w/ gcc 3.2.2.  If I'm 
> careful and do very little in X, it seems to stay up for a few days.  If 
> I do any sort of fast graphics or sound, etc, it'll die very quickly.  
> 'tis an instant death with no OOPS, nothing at all on screen, nothing on 
> serial console.

You're lucky, for me 2.5.60+ freezes right after "uncompressing kernel".
Tried with and without ACPI, with and without 'noapic', with APIC
enabled and disabled in the BIOS. 

2.5.59 is just unstable.

(msi kt4 ultra MB, athlon xp 2200+, gcc 3.2.2)

I'll try a minimal 2.5.62 now.

endre

