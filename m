Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbUJ3XZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUJ3XZw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUJ3XV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:21:57 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52171 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261436AbUJ3XUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:20:07 -0400
Subject: [OT] Re: code bloat [was Re: Semaphore assembly-code bug]
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Tim Hockin <thockin@hockin.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041030222720.GA22753@hockin.org>
	 <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 19:20:04 -0400
Message-Id: <1099178405.1441.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 02:13 +0300, Denis Vlasenko wrote:
> It's sort of frightening that someone will need to
> rewrite Xlib or, say, OpenOffice :(

I think very few application developers understand the point Linus made
- that bigger code IS slower code due to cache misses.  If this were
widely understood we would be in pretty good shape.

Lee

