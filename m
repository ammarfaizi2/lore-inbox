Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWJDU7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWJDU7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWJDU7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:59:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48608 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751123AbWJDU7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:59:01 -0400
Date: Wed, 4 Oct 2006 22:58:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fix] swsusp: Make userland suspend work on SMP again
Message-ID: <20061004205854.GG8440@elf.ucw.cz>
References: <200610042226.43833.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610042226.43833.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-10-04 22:26:42, Rafael J. Wysocki wrote:
> Unfortunately one of the recent changes in swsusp has broken the userland
> suspend on SMP.  Fix it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
ACK.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
