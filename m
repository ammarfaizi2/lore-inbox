Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWDGSo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWDGSo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWDGSo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:44:28 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:13576 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964860AbWDGSo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:44:27 -0400
Date: Fri, 7 Apr 2006 20:44:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
Message-ID: <20060407184400.GA9097@mars.ravnborg.org>
References: <20060406224134.0430e827.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406224134.0430e827.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 10:41:34PM -0700, Randy.Dunlap wrote:
> 
> In doing lots of kernel build testing, I often want to enable all options
> in a sub-menu and their sub-sub-menus.  Sound is one of the worst^W longest
> of these, so I chose a shorter (easier) one to practice on:  parport.
If there is a general need for this we shal enhance kconfig with this.
We shall not clutter the Kconfig files with this.

On the other hand the perl solutions posted seems also to do the trick
so lets see if that does the trick for now.

	Sam
