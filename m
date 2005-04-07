Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVDGHTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVDGHTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVDGHTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:19:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44963 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261749AbVDGHTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:19:07 -0400
Subject: Re: Kernel SCM saga..
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 08:18:50 +0100
Message-Id: <1112858331.6924.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 (2.2.1.1-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 08:42 -0700, Linus Torvalds wrote:
> PS. Don't bother telling me about subversion. If you must, start reading
> up on "monotone". That seems to be the most viable alternative, but don't
> pester the developers so much that they don't get any work done. They are
> already aware of my problems ;)

One feature I'd want to see in a replacement version control system is
the ability to _re-order_ patches, and to cherry-pick patches from my
tree to be sent onwards. The lack of that capability is the main reason
I always hated BitKeeper.

-- 
dwmw2

