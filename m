Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbTDFVRF (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTDFVRF (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:17:05 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:37037 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263086AbTDFVRE (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:17:04 -0400
Date: Sun, 6 Apr 2003 23:28:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: swsusp - 2.5.66 incremental
Message-ID: <20030406212818.GA693@elf.ucw.cz>
References: <1049537149.1709.6.camel@laptop-linux.cunninghams> <20030406182016.GA17666@atrey.karlin.mff.cuni.cz> <1049662843.8403.19.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049662843.8403.19.camel@laptop-linux.cunninghams>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Okay. So what do I have to do to get it taken?

Well, pretend it was taken and continue. When the time comes for a
real merge, gcc -S your files to generate assembly, and provide nice
patch to the .S file.

								Pavel
-- 
When do you have heart between your knees?
