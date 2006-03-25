Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWCYOuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWCYOuP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 09:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCYOuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 09:50:15 -0500
Received: from mx1.suse.de ([195.135.220.2]:49109 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751239AbWCYOuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 09:50:14 -0500
From: Andreas Schwab <schwab@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: ccache complains in latest git about -p
References: <200603251521.32217.ak@suse.de>
X-Yow: Am I accompanied by a PARENT or GUARDIAN?
Date: Sat, 25 Mar 2006 15:50:10 +0100
In-Reply-To: <200603251521.32217.ak@suse.de> (Andi Kleen's message of "Sat, 25
	Mar 2006 15:21:32 +0100")
Message-ID: <jemzfe37fh.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> ccache complains for me on x86-64 now:
>
>> make CC=ccache 

Didn't you mean CC="ccache gcc"?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
