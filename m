Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264889AbUEQE0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUEQE0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 00:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264888AbUEQE0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 00:26:47 -0400
Received: from [202.141.25.89] ([202.141.25.89]:65504 "EHLO
	cello.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S264889AbUEQE0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 00:26:46 -0400
To: linux-kernel@vger.kernel.org
Subject: swsusp also stores system clock
From: Rajsekar <raj.delete.se.here.too.kar@peacock.iitm.ernet.in>
Date: Mon, 17 May 2004 09:54:51 +0530
Message-ID: <y49oeonr88c.fsf@sahana.cs.iitm.ernet.in>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I started liking swsusp so much that I dont shutdown my system anymore, I
just suspend.  Is this wrong? 

But I noticed that the clock also gets saved and when I resume my system,
the clock is annoyingly wrong.  I suppose that this is done on purpose for
some reasons by the developers.

Currently, I use hwclock to set my system clock on resume.

Is there a better way or a patch ?

-- 
   M Rajsekar
   IIT Madras

