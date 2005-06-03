Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFCM2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFCM2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 08:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVFCM2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 08:28:33 -0400
Received: from mx1.suse.de ([195.135.220.2]:10173 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261240AbVFCM20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 08:28:26 -0400
From: Andreas Schwab <schwab@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       XIAO Gang <xiao@unice.fr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Suggestion on "int len" sanity
References: <429EB537.4060305@unice.fr>
	<20050602084840.GA32519@wohnheim.fh-wedel.de>
	<Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be>
X-Yow: Will the third world war keep ``Bosom Buddies'' off the air?
Date: Fri, 03 Jun 2005 14:28:25 +0200
In-Reply-To: <Pine.LNX.4.62.0506031143100.16362@numbat.sonytel.be> (Geert
	Uytterhoeven's message of "Fri, 3 Jun 2005 11:45:51 +0200 (CEST)")
Message-ID: <jer7fjeiae.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

>> 	union {
>> 		unsigned len;
>                 ^^^^^^^^
> Plain unsigned is deprecated.

Says who?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
