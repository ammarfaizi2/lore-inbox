Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUHEHFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUHEHFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267579AbUHEHFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:05:12 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8682 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267578AbUHEHFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:05:06 -0400
Date: Thu, 5 Aug 2004 08:51:53 +0200
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.8-rc2-mm2 with usb and input problems
Message-ID: <20040805065153.GC3984@gamma.logic.tuwien.ac.at>
References: <20040802162845.GA24725@gamma.logic.tuwien.ac.at> <20040802171325.GA26949@gamma.logic.tuwien.ac.at> <20040803081134.GA13745@gamma.logic.tuwien.ac.at> <200408041926.31293.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408041926.31293.david-b@pacbell.net>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!

On Mit, 04 Aug 2004, David Brownell wrote:
> Not clear how to read that stack; if it's usbdev_open()
> that's making the trouble, lock_kernel() is blocked.
> But that doesn't quite make sense to me.  Sorry!

So what now? Should I make other programs hang and check for the trace
there, and hope to find another trace? Or ignore it for now?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
AINDERBY STEEPLE (n.)
One who asks you a question with the apparent motive of wanting to
hear your answer, but who cuts short your opening sentence by leaning
forward and saying 'and I'll tell you why I ask...' and then talking
solidly for the next hour.
			--- Douglas Adams, The Meaning of Liff
