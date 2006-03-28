Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWC1F0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWC1F0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 00:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWC1F0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 00:26:22 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:53900 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751330AbWC1F0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 00:26:21 -0500
Subject: Re: [RFC][PATCH 2/2] Virtualization of IPC
From: Sam Vilain <sam@vilain.net>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       devel@openvz.org, serue@us.ibm.com
In-Reply-To: <20060324212713.GC22308@MAIL.13thfloor.at>
References: <44242B1B.1080909@sw.ru> <44242DFE.3090601@sw.ru>
	 <1143227600.19152.81.camel@localhost.localdomain>
	 <20060324212713.GC22308@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 17:26:30 +1200
Message-Id: <1143523590.7156.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 22:27 +0100, Herbert Poetzl wrote:
> maybe we should put all that stuff on a wiki too?

Good heavens, for the love of life and everything pure and good in the
world, no!

Perhaps we can get a kernel.org git tree?  Each submission can be put in
as seperate branches.

For instance I have already been doing this for several submissions, see

  http://vserver.utsl.gen.nz/gitweb/?p=vserver;a=heads

This doesn't include Dave's or Kirill's patches yet (as of -0328T15:53
+12).

OK, now it does (as of -0328T17:23+12).

I am more than happy to continue to track people's submissions in this
way, but they probably belong on kernel.org

Sam.

