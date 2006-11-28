Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757051AbWK1Wu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757051AbWK1Wu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757101AbWK1Wu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:50:56 -0500
Received: from outbound0.mx.meer.net ([209.157.153.23]:3080 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1757051AbWK1Wuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:50:55 -0500
Subject: Re: [PATCH 1/2 -mm] fault-injection: safer defaults, trivial
	optimization, cleanup
From: Don Mullis <dwm@meer.net>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Akinobu Mita <mita@miraclelinux.com>
In-Reply-To: <20061128133754.bad99ddb.akpm@osdl.org>
References: <1164699866.2894.88.camel@localhost.localdomain>
	 <20061128133754.bad99ddb.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 14:50:45 -0800
Message-Id: <1164754245.2894.144.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 13:37 -0800, Andrew Morton wrote:

> We'd prefer one-patch-per-concept, please. This all sounds like about
> six patches.

Understood.

> We _could_ merge this patch as-is, but it means that when this stuff
> finally hits mainline it would go in as a nice sequence of logical patches,
> followed by a random thing which is splattered all over all the preceding
> patches.

Does this argue for a respin of the original patches, folding in
content from this one, rather than splitting it into an additional six to
be appended to the series?

