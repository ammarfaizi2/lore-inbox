Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264198AbUE2UNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbUE2UNh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 16:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUE2UNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 16:13:36 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:62943 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S264198AbUE2UNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 16:13:35 -0400
Subject: Re: bk-3.2.0 released
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       bitkeeper-announce@work.bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040529154714.GC20605@work.bitmover.com>
References: <20040518233238.GC28206@work.bitmover.com>
	 <20040529095419.GB1269@ucw.cz> <20040529130436.GA20605@work.bitmover.com>
	 <20040529131510.GB13999@selene>  <20040529154714.GC20605@work.bitmover.com>
Content-Type: text/plain
Message-Id: <1085861614.2620.11.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 29 May 2004 13:13:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-29 at 08:47, Larry McVoy wrote:

> So is Fedora 1 OK with you?  Any
> nay sayers?

Fedora Core 1 and SuSE 9.0 use roughly the same version of glibc (2.3.2,
with some divergent patches), and the two seem fairly compatible in that
regard based on a little testing I just did.

If you use any libstdc++ stuff, you'll want to build on SuSE 9.0, which
has an older libstdc++.

	<b

