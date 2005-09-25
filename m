Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbVIYSN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbVIYSN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 14:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbVIYSN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 14:13:56 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:60320 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1751541AbVIYSNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 14:13:55 -0400
Date: Sun, 25 Sep 2005 11:20:26 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Sid Boyce <sboyce@blueyonder.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ktimers subsystem
In-Reply-To: <4336C6D8.4090602@blueyonder.co.uk>
Message-ID: <Pine.LNX.4.61.0509251120080.1684@montezuma.fsmlabs.com>
References: <4336C6D8.4090602@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2005, Sid Boyce wrote:

> OT, but something that's been bugging me for quite a while.
> I cut and paste the patch from the email to a file ktimers.patch.
> "# patch -l -p1 <ktimer.patch" and it returns ---
>  (Patch is indented 1 space.)
> patching file fs/exec.c
> patch: **** malformed patch at line 16: }
> 
> If I prepend 2 tabs to the line, it complains about line 17, I do the same to
> line 17 and on it moves to the next. from the manpage it reads like the "-l"
> should take care of the tabs so it only compares the text.
> Can anyone suggest how to apply the patch? Googling didn't help.

Save the entire email as a text file and apply it. Cut and paste usually 
introduces white space damage.

