Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWFUAuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWFUAuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWFUAuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:50:18 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:7132 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751880AbWFUAuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:50:17 -0400
Date: Tue, 20 Jun 2006 20:49:30 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [stable] [-stable PATCH] UML - fix uptime
Message-ID: <20060621004930.GA8274@ccure.user-mode-linux.org>
References: <200606202225.k5KMP3U5006871@ccure.user-mode-linux.org> <20060620225522.GK22737@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620225522.GK22737@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 03:55:22PM -0700, Chris Wright wrote:
> * Jeff Dike (jdike@addtoit.com) wrote:
> > The use of unsigned instead of unsigned here broke the calculations on
>              ^^^^^^^^            ^^^^^^^^
> Hard to imagine how that would cause a problem ;-)

Heh, feel free to fix.

> Queued for -stable, thanks.

Thanks.

			Jeff
