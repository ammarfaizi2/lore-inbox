Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWBGNlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWBGNlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWBGNlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:41:00 -0500
Received: from CPE-24-31-249-53.kc.res.rr.com ([24.31.249.53]:37567 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S965074AbWBGNlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:41:00 -0500
From: Luke-Jr <luke@dashjr.org>
To: davids@webmaster.com
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Date: Tue, 7 Feb 2006 13:40:58 +0000
User-Agent: KMail/1.9
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKGECCJPAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGECCJPAB.davids@webmaster.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071341.04052.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 21:07, David Schwartz wrote:
> > The LGPL deals with only derivative works. The GPL also deals with mere
> > *linking*. If glibc were GPL'd, it would be illegal to make an OS
> > based on it
> > with a single C program incompatible with the GPL.
>
> 	The GPL also only deals with derivative works. If linking does not create
> a derivative work, then the GPL cannot affect it. The GPL cannot define its
> own scope, only copyright law does that. GPL section zero states this, but
> even if it didn't it would still be true.

GPL can establish terms for distribution of the original software, even if it 
goes unmodified. In other words, by distributing the GPL software, one must 
agree that all software being distributed at the same time linking to it are 
GPL-compatible. The GPL cannot prohibit you from distributing the linking 
software in this case, but it can prohibit distribution of the original 
software.

> 	The GPL could say that it affected every work every created by any human
> being. It could say that it affected a work created by any person who ever
> used a GPL'd work. But these things would have no force because copyright
> law provides no such mechanism.

They would have force as conditions of distributing GPL software. If someone 
distributed software under the GPL, they would be accepting its terms and 
thus accepting that the GPL applies to all work they created. This example 
could be a bit extreme, however, and prohibited just on the grounds of being 
an invalidly-broad contract.

> 	The only way the GPL can control work Y because it affects work Z is
> because Y is a derivative work of work Z. If it's not, then the works are
> legally unrelated, and no matter what the GPL says, it can't affect work Y.

But it can prohibit distribution of work Z when work Y does not comply with 
the terms.

> 	If work Z is a "mere aggregate" containin all or part of work Y, then the
> GPL would still apply to work Y, but not to any part of work Z not from
> work Y.

Linking is not mere aggregation.
