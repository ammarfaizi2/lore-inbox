Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130119AbRAKUBS>; Thu, 11 Jan 2001 15:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131211AbRAKUBI>; Thu, 11 Jan 2001 15:01:08 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:38413 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S130119AbRAKUBA>;
	Thu, 11 Jan 2001 15:01:00 -0500
Message-ID: <3A5E10F5.716F83B7@holly-springs.nc.us>
Date: Thu, 11 Jan 2001 15:00:53 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: named streams, extended attributes, and posix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 2.4 is out, it will probably be a few .x releases until 2.5
begins.

A discussion on Named Streams and Extended Attributes was put off until
2.5 earlier in the 2.4 development cycle. For compatibility with
existing, widely-deployed filesystems (e.g., NFS, XFS, BeFS, HFS, etc.),
Linux needs a standard way to expose and interact with these filesystem
features. A draft of a paper proposing a methd for accomplishing this on
Posix systems is available at:

http://www.flyingbuttmonkeys.com/streams-on-posix.txt
http://www.flyingbuttmonkeys.com/streams-on-posix.pdf

Please read and comment! :)

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
