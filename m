Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUITLnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUITLnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUITLnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:43:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:45249 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266291AbUITLnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:43:31 -0400
To: Olaf Hering <olh@suse.de>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
	<20040920094602.GA24466@suse.de> <jeoek1xn9p.fsf@sykes.suse.de>
	<20040920105409.GH5482@DervishD>
From: Andreas Schwab <schwab@suse.de>
X-Yow: If a person is FAMOUS in this country, they have to go on the ROAD
 for MONTHS at a time and have their name misspelled on the SIDE
 of a GREYHOUND SCENICRUISER!!
Date: Mon, 20 Sep 2004 13:43:29 +0200
In-Reply-To: <20040920105409.GH5482@DervishD> (DervishD's message of "Mon,
 20 Sep 2004 12:54:09 +0200")
Message-ID: <jek6upxj1a.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <lkml@dervishd.net> writes:

>     Hi Andreas :)
>
>  * Andreas Schwab <schwab@suse.de> dixit:
>> > - fix all broken apps that still rely on mtab. like GNU df(1)
>> df does not rely on /etc/mtab.  It relies on getmntent.
>
>     Then my GNU df has any problem :???

No, if any then getmntent.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
