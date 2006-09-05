Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWIEMpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWIEMpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 08:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWIEMpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 08:45:18 -0400
Received: from baikonur.stro.at ([213.239.196.228]:42510 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S932177AbWIEMpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 08:45:15 -0400
Date: Tue, 5 Sep 2006 14:45:05 +0200
From: maximilian attems <maks@sternwelten.at>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060905124505.GE4868@baikonur.stro.at>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org> <20060905122656.GA3650@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905122656.GA3650@aepfle.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 02:26:56PM +0200, Olaf Hering wrote:
> On Sun, Sep 03, Linus Torvalds wrote:
> 
> > 
> > Things are definitely calming down, and while I'm not ready to call it a 
> > final 2.6.18 yet, this migt be the last -rc.
> 

there is a regression since 2.6.17 on some boxes:
http://bugzilla.kernel.org/show_bug.cgi?id=6875
http://bugzilla.kernel.org/show_bug.cgi?id=6920

the attached patch is known to fix the regression:
http://bugzilla.kernel.org/attachment.cgi?id=8798&action=view

-- 
maks
