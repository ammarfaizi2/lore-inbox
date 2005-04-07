Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVDGSPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVDGSPd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVDGSPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:15:32 -0400
Received: from ns1.s2io.com ([142.46.200.198]:56032 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S262553AbVDGSOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:14:30 -0400
Subject: Re: Kernel SCM saga..
From: Dmitry Yusupov <dima@neterion.com>
To: Daniel Phillips <phillips@istop.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200504071354.34581.phillips@istop.com>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504070810270.28951@ppc970.osdl.org>
	 <20050407171006.GF8859@parcelfarce.linux.theplanet.co.uk>
	 <200504071354.34581.phillips@istop.com>
Content-Type: text/plain
Organization: Neterion, Inc
Date: Thu, 07 Apr 2005 11:13:40 -0700
Message-Id: <1112897620.3893.62.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -102
X-Spam-Outlook-Score: ()
X-Spam-Features: EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,REPLY_WITH_QUOTES,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 13:54 -0400, Daniel Phillips wrote:
> Three years ago, there was no fully working open source distributed scm code 
> base to use as a starting point, so extending BK would have been the only 
> easy alternative.  But since then the situation has changed.  There are now 
> several working code bases to provide a good starting point: Monotone, Arch, 
> SVK, Bazaar-ng and others.

Right. For example, SVK is pretty mature project and very close to 1.0
release now. And it supports all kind of merges including Cherry-Picking
Mergeback:

http://svk.elixus.org/?MergeFeatures

Dmitry

