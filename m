Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270931AbTHQUaZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270986AbTHQUaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:30:24 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:14070 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S270931AbTHQUaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:30:23 -0400
Subject: Re: [PATCH] fix all warning deprecated in NTFS 1.1.22 (2.4)
From: Richard Russon <ntfs@flatcap.org>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030814035719.6905b4fd.vmlinuz386@yahoo.com.ar>
References: <20030814035719.6905b4fd.vmlinuz386@yahoo.com.ar>
Content-Type: text/plain
Message-Id: <1061152213.1114.42.camel@ipa.flatcap.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Aug 2003 21:30:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi djgera,

Anton isn't ignoring you, he's just extremely busy.

> total 191 warnings fixed!!! (it took enough hours to me)

Wow, thank you very much.  You've done an amazing job.

I've read through the patch (yawn) and tested it.  I found a couple of
problems (debug only), but they weren't your fault.  Several of the
ntfs_debug's had the wrong arguments.  I've rebuilt the patch and put it
here:

  http://flatcap.org/ntfs/fix.warning.deprecated.ntfs.patch2
  http://flatcap.org/ntfs/fix.warning.deprecated.ntfs.patch2.bz2

> Please review, and confirm to Marcelo Tosatti

Now we just need to keep poking Anton :-)

Thanks for your hard work.

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org

WWW: http://linux-ntfs.sourceforge.net
IRC: #ntfs on irc.freenode.net


