Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUHKXNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUHKXNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUHKXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:13:24 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:12765 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S268336AbUHKXLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:11:32 -0400
Date: Wed, 11 Aug 2004 16:11:30 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] Remove CONFIG_SERIAL_8250_MANY_PORTS from Ebony / Ocotea
Message-ID: <20040811161130.E8378@home.com>
References: <20040811225729.GG390@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040811225729.GG390@smtp.west.cox.net>; from trini@kernel.crashing.org on Wed, Aug 11, 2004 at 03:57:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 03:57:29PM -0700, Tom Rini wrote:
> CONFIG_SERIAL_8250_MANY_PORTS should not be set for these boards, as
> they only have 2 serial ports.

<snip>

Looks good to me.

-Matt
