Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTENWfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTENWfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:35:04 -0400
Received: from smtp-out3.iol.cz ([194.228.2.91]:22759 "EHLO smtp-out3.iol.cz")
	by vger.kernel.org with ESMTP id S263055AbTENWfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:35:00 -0400
Date: Thu, 15 May 2003 00:45:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
Message-ID: <20030514224550.GB8124@elf.ucw.cz>
References: <20030514120950.GA302@elf.ucw.cz> <Pine.LNX.4.44.0305142248040.13403-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305142248040.13403-100000@phoenix.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There are more problems. Emacs changes cursor to "more visible" one,
> > this somehow leaks between ttys.
> 
> Hm. I can't seem to reproduce this problem.

Also play a bit with gpm's selection. Sometimes cursor gets
corrupted. Like its no longer underline or block, it is something
strange.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
