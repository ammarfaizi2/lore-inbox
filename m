Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbTELAen (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTELAen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:34:43 -0400
Received: from pfaff.Stanford.EDU ([128.12.189.154]:46721 "EHLO
	pfaff.Stanford.EDU") by vger.kernel.org with ESMTP id S261562AbTELAen
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:34:43 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
References: <20030511164010$5d34@gated-at.bofh.it>
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 11 May 2003 17:47:24 -0700
In-Reply-To: <20030511164010$5d34@gated-at.bofh.it>
Message-ID: <87vfwhyorn.fsf@pfaff.Stanford.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might want to read this paper on application sandboxing:
        http://www.stanford.edu/~talg/papers/traps/abstract.html
It covers a lot of the wrong ways to do things.
-- 
"MONO - Monochrome Emulation
 This field is used to store your favorite bit."
--FreeVGA Attribute Controller Reference
