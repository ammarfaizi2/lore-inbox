Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVDKInc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVDKInc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 04:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVDKInc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 04:43:32 -0400
Received: from mail.enyo.de ([212.9.189.167]:53738 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261731AbVDKIkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 04:40:14 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
       Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
References: <20050410174221.GD7858@alpha.home.local>
	<20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz>
	<Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
	<20050410222737.GC5902@pasky.ji.cz>
	<Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org>
	<20050410232637.GC18661@pasky.ji.cz>
	<Pine.LNX.4.58.0504101639130.1267@ppc970.osdl.org>
	<20050410235617.GE18661@pasky.ji.cz>
	<Pine.LNX.4.58.0504101716420.1267@ppc970.osdl.org>
	<20050411074523.GB5485@elte.hu>
Date: Mon, 11 Apr 2005 10:40:00 +0200
In-Reply-To: <20050411074523.GB5485@elte.hu> (Ingo Molnar's message of "Mon,
	11 Apr 2005 09:45:23 +0200")
Message-ID: <871x9hemfz.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar:

> is there any fundamental problem with going with v2 right now, and then 
> once v3 is out and assuming it looks ok, all newly copyrightable bits 
> (new files, rewrites, substantial contributions, etc.) get a v3 
> copyright? (and the collection itself would be v3 too) That method 
> wouldnt make it fully v3 automatically once v3 is out, but with time 
> there would be enough v3 bits in it to make it essentially v3.

Almost certainly, v3 will be incompatible with v2 because it adds
further restrictions.  This means that your proposal would result in
software which is not redistributable by third parties.
