Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273076AbRIIWJV>; Sun, 9 Sep 2001 18:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273077AbRIIWJC>; Sun, 9 Sep 2001 18:09:02 -0400
Received: from [209.202.108.240] ([209.202.108.240]:55311 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S273076AbRIIWI6>; Sun, 9 Sep 2001 18:08:58 -0400
Date: Sun, 9 Sep 2001 18:09:04 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Lockup with 2.4.9-ac10 on Athlon
In-Reply-To: <Pine.LNX.4.33.0109091343580.22125-100000@terbidium.openservices.net>
Message-ID: <Pine.LNX.4.33.0109091804450.1105-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Sep 2001, Ignacio Vazquez-Abrams wrote:

> I'm running RH7.1+2.4.9-ac10 (K7-optimized) on an Asus A7V (KT133) and an
> Athlon C 1.4GHz (currently running on a 100/200MHz FSB at 1050MHz).
>
> This system experiences lockups during shutdon, and sometimes also when
> SIGTERMing tasks.

I have verified that the problem happens when both K6 and i386 have been
chosen as the processor type.

SysRq also has no effect in any case. /var/log/messages doesn't list anything
due to the fact that syslog has already been killed.

Could the APM settings that I have chosen have anything to do with this?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

