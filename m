Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbTDXUJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTDXUJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:09:16 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:33543 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263825AbTDXUJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:09:13 -0400
Date: Thu, 24 Apr 2003 16:14:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Valdis.Kletnieks@vt.edu, Pau Aliagas <linuxnow@newtral.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.67
In-Reply-To: <20030422192542.C31709@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030424160718.11351A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Russell King wrote:

> Linus isn't particularly enthralled with the fix there, so I'm working on
> a replacement version.  (Hell, I'm not that happy with that fix either,
> but it does fix the problem.)
> 
> The replacement version is something I was planning on doing anyway, just
> that its happening earlier than I really wanted it.

How about an "ugly patches" repository? Some central place for patches
which solve problems but are not esthetically pleasing. There would be
multiple benefits; those who want a fix and don't care if it will go
forward can get their system working, the ugly patch will remain as a flag
that the problem needs to be properly fixed, and the content of the patch
may help someone else understand and beautify the solution or come up with
a whole new solution based on better understanding.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

