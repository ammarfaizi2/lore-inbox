Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbUDUAMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbUDUAMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUDUAMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:12:45 -0400
Received: from dsl081-240-014.sfo1.dsl.speakeasy.net ([64.81.240.14]:45522
	"EHLO tumblerings.org") by vger.kernel.org with ESMTP
	id S262733AbUDUAMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:12:43 -0400
Date: Tue, 20 Apr 2004 17:12:36 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: matching "Cset exclude" changelog entries to the changelog entries they revert.
Message-ID: <20040421001236.GA16901@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I count 79 "Cset exclude" changelog entries since 2.5.4-pre1. Is there any
way to identify the changelog entry they revert?

for instance, "Cset exclude: davej@suse.de|ChangeSet|20020403195622" is in
2.5.8-pre2, as the full text of the changelog entry.

Without a way to identify the particular entry being reverted, I can't rely
on the fact that a particular changelog entry represents what actually went
into the kernel.

I realize there is almost certainly no way to directly deduce which changelog
entry is referenced by a particular 'Cset exclude' entry. But maybe there
is some *indirect* way, perhaps a website somewhere that tracks this info?

If this information isn't provided anywhere, what would be involved in
making it available? Maybe something can be done for the future.

Many thanks,
Zack

-- 
Zack Brown
