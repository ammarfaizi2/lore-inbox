Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUCHXnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 18:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUCHXnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 18:43:33 -0500
Received: from ns.suse.de ([195.135.220.2]:5605 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261408AbUCHXna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 18:43:30 -0500
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
References: <200403090014.03282.thomas.schlichter@web.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Half a mind is a terrible thing to waste!
Date: Tue, 09 Mar 2004 00:43:29 +0100
In-Reply-To: <200403090014.03282.thomas.schlichter@web.de> (Thomas
 Schlichter's message of "Tue, 9 Mar 2004 00:14:01 +0100")
Message-ID: <jeptbmlxb2.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <thomas.schlichter@web.de> writes:

> P.S.: Wouldn't it be nice if gcc complained about these mistakes?

Among these 18 cases are 13 false positives. :-)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
