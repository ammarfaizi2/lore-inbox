Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUCZDR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUCZDR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:17:58 -0500
Received: from sa-4.airstreamcomm.net ([64.33.192.164]:33286 "EHLO
	sa-4.airstreamcomm.net") by vger.kernel.org with ESMTP
	id S263662AbUCZDRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:17:53 -0500
To: 239952@bugs.debian.org, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <81ptb0wh45.wl@omega.webmasters.gr.jp>
	<MDEHLPKNGKAHNMBLJOLKAEFILEAA.davids@webmaster.com>
	<20040326025909.GY9248@cheney.cx>
From: John Hasler <john@dhh.gt.org>
Date: Thu, 25 Mar 2004 21:23:33 -0600
In-Reply-To: <20040326025909.GY9248@cheney.cx> (Chris Cheney's message of
 "Thu, 25 Mar 2004 20:59:09 -0600")
Message-ID: <87smfw9tqi.fsf@toncho.dhh.gt.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris writes:
> So is a reverse engineered driver where there is a binary blob the
> preferred form of source?

Where did the blob come from?  If the author wrote it in binary (unlikely),
then it's ok.  If he wrote it in hex (I've done that) he should supply a
hex file from which the blob can be generated.

> Of course reverse engineered drivers with binary blobs in them are
> probably copyright infringements anyway...

If the author ripped the blob out of someone else's closed-source binary
driver it certainly is.  It also is a GPL violation.
-- 
John Hasler               You may treat this work as if it 
john@dhh.gt.org           were in the public domain.
Dancing Horse Hill        I waive all rights.
Elmwood, Wisconsin
