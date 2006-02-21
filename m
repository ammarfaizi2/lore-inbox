Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWBUTIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWBUTIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 14:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWBUTIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 14:08:25 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:18187 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932252AbWBUTIZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 14:08:25 -0500
Date: Tue, 21 Feb 2006 20:08:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the CONFIG_CC_ALIGN_* options
Message-ID: <20060221190815.GA9430@mars.ravnborg.org>
References: <20060220223654.GR4661@stusta.de> <20060221175640.GB9070@mars.ravnborg.org> <20060221184406.GZ4661@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221184406.GZ4661@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 07:44:07PM +0100, Adrian Bunk wrote:
> > 
> > But if we back-out this then cc-option-aling should go as well,
> > including description in Documentation/kbuild/makefiles.txt
> 
> My patch doesn't remove cc-option-align, and it's still used in 
> arch/i386/Makefile.cpu.
Right you are - thanks.

	Sam
