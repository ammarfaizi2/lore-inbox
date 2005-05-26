Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVEZNiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVEZNiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 09:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVEZNip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 09:38:45 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:28614 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261436AbVEZNin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 09:38:43 -0400
Subject: No full image on kernel.org home page.
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: webmaster@kernel.org
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 26 May 2005 09:38:34 -0400
Message-Id: <1117114714.4313.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just wondering why there's only patches to download from the kernel.org
home page?  It would be nice if you could also download the image that
you needed to patch against.  I know I can easily get the images by
cruising down the links of either the HTML or FTP.

If the full image is not there to have people use the patches more
often, then it would make more sense to have a link on the main page to
the image to patch against. If I have to make the effort to follow the
links down to get a image, I'll just take the full image of the one I
want instead of the patch.  This means that the next time I get a image,
I need to download the whole thing again.

So having something like this:

The latest stable version of the Linux kernel is:  2.6.11.10  (patched against 2.6.11)

Having the 2.6.11.10 be a link to the patch and 2.6.11 the full bz2
image tar ball.  When I get a image I would get the 2.6.11, then the
patch. The next time I would only need to get the patch.  Otherwise,
being lazy and a procrastinator, I would follow the links and download
the 2.6.11.10 tarball.  (lazy since I don't need to do any patching, a
procrastinator since I could have downloaded the 2.6.11 to patch against
next time but just say "I'll do that later!").

Cheers,

-- Steve


