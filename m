Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTJKLK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 07:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTJKLK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 07:10:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:62481 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263274AbTJKLK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 07:10:56 -0400
Date: Sat, 11 Oct 2003 13:10:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] deb target
Message-ID: <20031011111055.GA932@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031011082253.GA565@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011082253.GA565@wiggy.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 10:22:53AM +0200, Wichert Akkerman wrote:
> 
> For a while now I've been missing a deb target in kbuild, especially
> since there is a simple rpm target. While Debian does have a tool
> to create kernel packages (make-kpkg from the kernel-package package)
> I felt there was a need for a simpler method build into kbuild.

Thanks.
I will save the patch until later.
For now we are in bug-fix mode, and this is clearly new functionality.

	Sam
