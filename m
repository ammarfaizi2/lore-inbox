Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVI2WMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVI2WMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVI2WMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:12:49 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:26525 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751330AbVI2WMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:12:48 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 29 Sep 2005 23:12:37 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
In-Reply-To: <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
Message-ID: <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <20050929213312.GD31516@redhat.com>
 <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Linus Torvalds wrote:
> On Thu, 29 Sep 2005, Dave Jones wrote:
> > What I find amusing is that it was a patch rejection mail from you
> > *years* back (circa 2000 iirc), telling me my pine corrupted whitespace,
> > that made me switch MUA ;-)
> > 
> > All these years later, and it's still buggered ?
> 
> Actually, it seems better. It seems to be buggered by default, but it used 
> to be that you had to actually recompile pine to make it behave. Now you 
> can just disable "strip-whitespace-before-send" and _enable_ 
> "quell-flowed-text" and those together seem to do the trick. No extra 
> patches or recompiles necessary.

Indeed.  I use those two options like that, too.  (-:

> So there's progress. 
> 
> Of course, pico is still pico. Which I find a bit sad: my editor of choise 
> is still an improved version of uemacs, and pico actually comes from the 
> same uemacs history, but has different key-bindings for just enough keys 
> to be slightly confusing.
> 
> Still, that shared history means that I find pico a lot more to my taste 
> than just about any other emailer editor out there. It may have a few 
> differences, but it has more things in common..

Why don't you enable "enable-alternate-editor-implicitly" and set 
editor = "your-editor-of-choice" in the pine config?  It is integrated in 
a quite seamless way.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
