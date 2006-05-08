Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWEHUXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWEHUXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 16:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWEHUXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 16:23:32 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:7953 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750782AbWEHUXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 16:23:32 -0400
Date: Mon, 8 May 2006 22:23:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL-only symbols issue
Message-ID: <20060508202333.GB4340@mars.ravnborg.org>
References: <445F0B6F.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445F0B6F.76E4.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 09:12:15AM +0200, Jan Beulich wrote:
> Sam,
> 
> would it seem reasonable a request to detect imports of GPL-only symbols by non-GPL modules also at build time rather
> than only at run time, and at least warn about such?

It should be trivial since we have the information. But I'm not the one
to say if it is reasonable.
If you do not beat me I can try to cook something up within a few
weeks (busy with work-work atm).

	Sam
