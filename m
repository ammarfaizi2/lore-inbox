Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161557AbWJKWMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161557AbWJKWMM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWJKWML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:12:11 -0400
Received: from ns1.suse.de ([195.135.220.2]:43919 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161556AbWJKWMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:12:07 -0400
From: Andreas Schwab <schwab@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] m68k: more workarounds for recent binutils idiocy
References: <E1GXlNt-0004Xc-Fi@ZenIV.linux.org.uk>
X-Yow: Disco oil bussing will create a throbbing naugahide pipeline running
 straight to the tropics from the rug producing regions
 and devalue the dollar!
Date: Thu, 12 Oct 2006 00:12:05 +0200
In-Reply-To: <E1GXlNt-0004Xc-Fi@ZenIV.linux.org.uk> (Al Viro's message of
	"Wed, 11 Oct 2006 22:13:01 +0100")
Message-ID: <jek636o62y.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> cretinous thing doesn't believe that (%a0)+ is one macro argument and
> splits it in two; worked around by quoting the argument...

What version are you using?  Works rather fine here with 2.17.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
