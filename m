Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTEGLFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 07:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTEGLFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 07:05:04 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:42967 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263073AbTEGLFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 07:05:03 -0400
Date: Wed, 7 May 2003 13:15:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: bkcvs not up-to-date?
Message-ID: <20030507111552.GA325@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have just done 

rsync -zav --delete rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5 .

and checked out the tree, but cvs log Makefile still indicates 2.5.68
is the lastest version. What am I doing wrong?

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
