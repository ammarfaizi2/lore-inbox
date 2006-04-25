Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWDYJTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWDYJTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWDYJTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:19:45 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:17853 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932162AbWDYJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:19:45 -0400
Date: Tue, 25 Apr 2006 11:19:43 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hzhong@gmail.com
Subject: Re: [PATCH] Profile likely/unlikely macros
Message-ID: <20060425091943.GA28917@rhlx01.fht-esslingen.de>
References: <200604250257.k3P2vlEb012502@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604250257.k3P2vlEb012502@dwalker1.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 24, 2006 at 07:57:47PM -0700, Daniel Walker wrote:
> This patch adds a very lightweight profiling feature to the
> likely/unlikely macros. It should work in all contexts including
> NMI, and during boot. The patch is for 2.6.17-rc2 . 

Wow, very nice! I had actually had that idea myself, so it's nice to see
it already implemented, and with very nice output.
Rest assured that I'll do my fair share of testing with it!

Thanks a lot!

Andreas Mohr
