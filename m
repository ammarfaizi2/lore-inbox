Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWEUIuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWEUIuT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 04:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWEUIuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 04:50:18 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:23471 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751478AbWEUIuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 04:50:17 -0400
Date: Sun, 21 May 2006 01:50:15 -0700
From: Chris Wedgwood <cw@f00f.org>
To: dragoran <dragoran@feuerpokemon.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-ID: <20060521085015.GB2535@taniwha.stupidest.org>
References: <44702650.30507@feuerpokemon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44702650.30507@feuerpokemon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 10:35:28AM +0200, dragoran wrote:

> IA32 syscall 311 from mozilla-xremote not implemented
> IA32 syscall 311 from firefox-bin not implemented
> IA32 syscall 311 from mplayer not implemented
> what is syscall 311  and what effect does this have?

sys_set_robust_list, I think it's futex related

> I am using 2.6.16-1.2111_FC5 (2.6.16.14)

probably best to bitch to Red Hat about this

