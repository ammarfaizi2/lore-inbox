Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWA1V2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWA1V2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 16:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWA1V2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 16:28:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:3337 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750764AbWA1V2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 16:28:12 -0500
Date: Sat, 28 Jan 2006 22:27:57 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [mips] Accept various mips sub-types in SUBARCH
Message-ID: <20060128212757.GB10548@mars.ravnborg.org>
References: <20060128183815.GA27304@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128183815.GA27304@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 06:38:15PM +0000, Martin Michlmayr wrote:
> uname -m on MIPS can give a number of results, such as mips64.  We
> need to add another substitution to the sed call for SUBARCH in the
> main Makefile.
Applied,
	Sam
