Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWGKIfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWGKIfP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWGKIfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:35:15 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52669 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750751AbWGKIfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:35:13 -0400
Date: Tue, 11 Jul 2006 10:34:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 2/2] swsusp: struct snapshot_handle cleanup
Message-ID: <20060711083446.GC1787@elf.ucw.cz>
References: <200607102240.45365.rjw@sisk.pl> <200607102316.48641.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607102316.48641.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-07-10 23:16:48, Rafael J. Wysocki wrote:
> Add comments describing struct snapshot_handle and its members,
> change the confusing name of its member 'page' to 'cur'.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
