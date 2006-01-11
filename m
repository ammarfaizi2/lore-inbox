Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWAKWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWAKWPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWAKWPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:15:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42381 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751110AbWAKWPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:15:23 -0500
Date: Wed, 11 Jan 2006 23:15:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Place for userland swsusp parts
Message-ID: <20060111221511.GA8223@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is there some place where we could  put userland swsusp parts under
version control?

swsusp.sf.net looks like possible place, but it has been in use by
suspend2... Is it still being used? If not, would it be possible to
"hijack" it for swsusp development?
								Pavel
-- 
Thanks, Sharp!
