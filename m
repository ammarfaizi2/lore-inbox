Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWJEU1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWJEU1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWJEU1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:27:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20615 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751276AbWJEU1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:27:54 -0400
From: Andreas Schwab <schwab@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc1: known regressions
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<20061005042816.GD16812@stusta.de>
	<1160023503.22232.10.camel@localhost.localdomain>
X-Yow: Today, THREE WINOS from DETROIT sold me a framed photo of
 TAB HUNTER before his MAKEOVER!
Date: Thu, 05 Oct 2006 22:27:51 +0200
In-Reply-To: <1160023503.22232.10.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Thu, 05 Oct 2006 14:45:03 +1000")
Message-ID: <jevemyv77c.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2006-10-05 at 06:28 +0200, Adrian Bunk wrote:
>> Contrary to popular belief, there are people who test -rc kernels
>> and report bugs.
>> 
>> And there are even people who test -git kernels.
>> 
>> This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18.
>> 
>> If you find your name in the Cc header, you are either submitter of one
>> of the bugs, maintainer of an affectected subsystem or driver, a patch
>> of you was declared guilty for a breakage or I'm considering you in any
>> other way possibly involved with one or more of these issues.
>> 
>> Due to the huge amount of recipients, please trim the Cc when answering.
>
> Add sleep/wakeup on powerbooks apparently busted. Haven't tracked down
> yet.

Does not even boot for me (iBook G4).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
