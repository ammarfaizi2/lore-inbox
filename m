Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWGFRWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWGFRWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWGFRWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:22:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16311 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030313AbWGFRWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:22:08 -0400
Subject: Re: Driver for Microsoft USB Fingerprint Reader
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060706044838.30651.qmail@science.horizon.com>
References: <20060706044838.30651.qmail@science.horizon.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Jul 2006 18:38:39 +0100
Message-Id: <1152207519.13734.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-06 am 00:48 -0400, ysgrifennodd linux@horizon.com:
> As far as I can tell, the only thing you want is AUTHENTICATION - you
> want proof that you are getting a "live" scan taken from a user
> who's present, and not a replay of what was sent last week.

Read the papers on the subject. If I can get copies of the unencrypted
data I can use those to make fake fingers. 

A finger print is personal data, arguably sensitive personal data. That
means there are lots of duties to store it securely. It is also very
hard to revoke a fingerprint so theft of data is highly problematic as
it will allow me to generate fake fingers. Theft of encrypted data might
allow replay attacks on one PC. Big deal.

Alan

