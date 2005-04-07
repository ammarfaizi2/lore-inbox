Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVDGJZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVDGJZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVDGJZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:25:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11174 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262402AbVDGJZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:25:23 -0400
Subject: Re: Kernel SCM saga..
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050407015019.4563afe0.akpm@osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <1112858331.6924.17.camel@localhost.localdomain>
	 <20050407015019.4563afe0.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 10:25:18 +0100
Message-Id: <1112865919.24487.442.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 01:50 -0700, Andrew Morton wrote:
> (I don't do that for -mm because -mm basically doesn't work for 99% of
> the time.  Takes 4-5 hours to out a release out assuming that
> nothing's busted, and usually something is).

On the subject of -mm: are you going to keep doing the BK imports to
that for the time being, or would it be better to leave the BK trees
alone now and send you individual patches.

For that matter, will there be a brief amnesty after 2.6.12 where Linus
will use BK to pull those trees which were waiting for that, or will we
all need to export from BK manually?

-- 
dwmw2

