Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTJ0Xbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTJ0Xbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:31:38 -0500
Received: from main.gmane.org ([80.91.224.249]:49836 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263660AbTJ0Xbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:31:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: Blockbusting news, results get worse
Date: Mon, 27 Oct 2003 23:31:33 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnbpraml.2e6.lunz@absolut.localnet>
References: <785F348679A4D5119A0C009027DE33C105CDB39B@mcoexc04.mlm.maxtor.com> <3cba01c39c6f$141529a0$24ee4ca5@DIAMONDLX60>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ndiamond@wta.att.ne.jp said:
> Yeah, I need to deliberately damage one block in order to test the
> firmware, but I don't want to damage multiple blocks and use up the
> reallocation space.  I am a home user, even if I also do programming
> at work, even if I also volunteer one day each weekend to test Linux.
> How can I arrange to damage one block on a disk?

I have two ata100 drives sitting at home right now that fill dmesg with
lots of UnrecoverableErrors whenever you access certain sectors. I'll
ship them to anyone who will use them to make linux error recovery more
resilient, either at the ide driver level or in the filesystem.

any takers?

Jason

