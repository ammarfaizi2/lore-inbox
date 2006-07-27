Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWG0LKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWG0LKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWG0LKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:10:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36055 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751144AbWG0LKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 07:10:50 -0400
Date: Thu, 27 Jul 2006 13:10:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] Allow cifsd to suspend if connection is lost
Message-ID: <20060727111031.GA1762@elf.ucw.cz>
References: <200607270914.08774.rjw@sisk.pl> <200607270946.49478.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607270946.49478.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-07-27 09:46:49, Rafael J. Wysocki wrote:
> Make cifsd allow us to suspend if it has lost the connection with the server.
> 
> Ref. http://bugzilla.kernel.org/show_bug.cgi?id=6811
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK and thanks.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
