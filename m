Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267503AbUHSW6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267503AbUHSW6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUHSW6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:58:49 -0400
Received: from cantor.suse.de ([195.135.220.2]:39371 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267491AbUHSW6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:58:24 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: GNU make alleged of "bug" (was: PATCH: cdrecord: avoiding scsi
 device numbering for ide devices)
References: <200408191600.i7JG0Sq25765@tag.witbe.net>
	<200408191341.07380.gene.heskett@verizon.net>
	<20040819194724.GA10515@merlin.emma.line.org>
	<20040819220553.GC7440@mars.ravnborg.org>
	<20040819205301.GA12251@merlin.emma.line.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..  over in west Philadelphia a puppy is vomiting..
Date: Fri, 20 Aug 2004 00:58:21 +0200
In-Reply-To: <20040819205301.GA12251@merlin.emma.line.org> (Matthias
 Andree's message of "Thu, 19 Aug 2004 22:53:01 +0200")
Message-ID: <je8ycad9bm.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> writes:

> On Fri, 20 Aug 2004, Sam Ravnborg wrote:
>
>> Using:
>> -include hello.d
>> will result in a silent make.
>
> Indeed it will. However, Solaris' /usr/ccs/bin/make doesn't understand
> the "-include" form:
>
> make: Fatal error in reader: Makefile, line 5: Unexpected end of line seen
>
> include without leading "-" is fine. BSD make doesn't understand either
> form.

What about sinclude?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
