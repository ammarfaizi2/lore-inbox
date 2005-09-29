Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVI2WdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVI2WdI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVI2WdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:33:08 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:41386 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932300AbVI2WdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:33:05 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 29 Sep 2005 23:32:57 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Dave Jones <davej@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
In-Reply-To: <Pine.LNX.4.64.0509291521300.5362@g5.osdl.org>
Message-ID: <Pine.LNX.4.60.0509292330130.17860@hermes-1.csi.cam.ac.uk>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <Pine.LNX.4.60.0509292106080.17860@hermes-1.csi.cam.ac.uk>
 <20050929201127.GB31516@redhat.com> <Pine.LNX.4.64.0509291413060.5362@g5.osdl.org>
 <Pine.LNX.4.64.0509291425560.5362@g5.osdl.org> <20050929213312.GD31516@redhat.com>
 <Pine.LNX.4.64.0509291451540.5362@g5.osdl.org>
 <Pine.LNX.4.60.0509292309470.17860@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.64.0509291521300.5362@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Linus Torvalds wrote:
> On Thu, 29 Sep 2005, Anton Altaparmakov wrote:
> > Why don't you enable "enable-alternate-editor-implicitly" and set 
> > editor = "your-editor-of-choice" in the pine config?  It is integrated in 
> > a quite seamless way.
> 
> You think so? I don't find it that way.
> 
> With an alternate editor you have to edit the headers separately, and 
> things like postponing a message suddenly turns into a big deal, not just 
> a trivial ^O. In fact, almost everything gets more involved.

Well using vim as alternate editor a postpone turns into a "ZZ" followed 
by ^O which I don't think is such a big deal but in general I agree that 
it adds hassle.  It is a shame that the text based headers do not appear 
as part of the message in the editor in particular...
 
> And pico _is_ pretty close to uemacs.

I wouldn't know about that.  Never used uemacs.  I am a vim addict myself.  
(-;

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
