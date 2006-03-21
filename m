Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWCULJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWCULJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWCULJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:09:59 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63658 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964858AbWCULJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:09:58 -0500
Subject: Re: SubmittingPatches typo
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Matheus Izvekov <mizvekov@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060320210209.GD31512@fieldses.org>
References: <20060320125012.GA21545@elf.ucw.cz>
	 <Pine.LNX.4.61.0603202056100.14231@yvahk01.tjqt.qr>
	 <305c16960603201247p53718859ofa0e6d0355c9da1a@mail.gmail.com>
	 <20060320210209.GD31512@fieldses.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Mar 2006 11:16:19 +0000
Message-Id: <1142939779.21455.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nope.  It's actually one of the amusing places where there *is* no rule.
> Plurals that end in s always get just the apostrophe.  But for singular
> nouns that end in s, while I tend to think of "'s" as the default, some
> people like to drop the final s if the result ("Sophocles's") would
> otherwise sound awkward spoken aloud.

The definitive references have this to say

US English: Strunk and White says it should be "Torvalds's" and that the
apostrophe alone is used only for ancient particularly biblical names
ending in -es/is  (eg Moses' laws)

UK English: The Oxford Guide To Style says

"Use 's after non-classical or non-classicizing personal names ending
with an s or z sound). It also says that Torvalds' would be acceptable.


So both agree that

	Torvalds's

is correct and that would appear to be the right choice to keep everyone
both sides of the pond happy.

Jan: Care to submit an updated patch as the original is indeed wrong ?

Alan

