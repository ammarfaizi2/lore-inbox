Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310399AbSCBQeh>; Sat, 2 Mar 2002 11:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310400AbSCBQe0>; Sat, 2 Mar 2002 11:34:26 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:53473 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S310399AbSCBQeN>; Sat, 2 Mar 2002 11:34:13 -0500
Subject: Re: dell inspiron and 2.4.18?
From: NyQuist <nyquist@ntlworld.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0203021111530.22434-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0203021111530.22434-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 02 Mar 2002 16:19:20 +0000
Message-Id: <1015085960.24870.9.camel@stinky.pussy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-02 at 16:13, Mark Hahn wrote:
> > Even though I wouldn't go so far as to call the 2.4 series stable (not
> 
> it is.  at least in the sense of not "locking up" under normal loads.
> 
> > spent in front of the computer are dulling my senses; i've had
> > intermittent lock-ups and 'soft'-locks, where hardly any processing is
> > done. I'm running 2.4.17 on a dell dimension. 
> 
> apm and/or acpi active?
> 
.config

CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set
# CONFIG_ACPI is not set

It's quite wierd, a couple of days ago, it soft-locked several times
whilst playing a dvd (no h/w decoder so probably load problems), and
yesterday it completely slowed (to a near halt - and in the middle of
coding aswell :(). I'm now unsure whether my hdd is on the edge of
collapse (time to backup), or my old p3 500 is on the blink.

-- 
NyQuist | Matthew Hall -- NyQuist at ntlworld dot com --
http://NyQuist.port5.com
Sig: #define QUESTION ((bb) || !(bb))

