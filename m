Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWFOL5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWFOL5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWFOL5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:57:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:62421 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030266AbWFOL5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:57:03 -0400
From: Andreas Schwab <schwab@suse.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] affs_fill_super() %s abuses
References: <20060615110355.GH27946@ftp.linux.org.uk>
X-Yow: The appreciation of the average visual graphisticator alone is worth
 the whole suaveness and decadence which abounds!!
Date: Thu, 15 Jun 2006 13:56:59 +0200
In-Reply-To: <20060615110355.GH27946@ftp.linux.org.uk> (Al Viro's message of
	"Thu, 15 Jun 2006 12:03:55 +0100")
Message-ID: <jever2aayc.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> %s is valid only on NUL-terminated arrays, damnit!

Unless it specifies an approriate precision.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
