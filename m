Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbUKHMlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbUKHMlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 07:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbUKHMlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 07:41:00 -0500
Received: from main.gmane.org ([80.91.229.2]:14505 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261831AbUKHMky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 07:40:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nuutti Kotivuori <naked@iki.fi>
Subject: Re: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
Date: Mon, 08 Nov 2004 14:28:03 +0200
Organization: Ye 'Ol Disorganized NNTPCache groupie
Message-ID: <871xf4a5kc.fsf@aka.i.naked.iki.fi>
References: <200411041932.39733.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: naked.iki.fi
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:/Jk+3nw3E2ATEmCNXqS+rK0882U=
Cache-Post-Path: aka.i.naked.iki.fi!unknown@aka.i.naked.iki.fi
X-Cache: nntpcache 3.0.1 (see http://www.nntpcache.org/)
Cc: user-mode-linux-devel@lists.sourceforge.net,
       user-mode-linux-user@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
> Changes in both 2.6.9 and 2.4.27:
> they run fine on 2.6.9 host kernels, without hanging at the exit.

I want to get this clear:

Every older guest UML kernel will hang on exit on 2.6.9 hosts from now
on, and there's nothing to fix it but to update the guest UML patches?

This is a nasty limitation in general - because it means that on the
update to 2.6.9, every kernel binary needs to be updated - and finding
rock solid versions of kernels + UML patches is not a fast process.

-- Naked


