Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265267AbUFHREz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUFHREz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 13:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUFHREy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 13:04:54 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:1023 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265257AbUFHREr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 13:04:47 -0400
Date: Tue, 8 Jun 2004 13:06:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMBFS crash
In-Reply-To: <20040608123656.GG14247@lbsd.net>
Message-ID: <Pine.LNX.4.58.0406081259570.1838@montezuma.fsmlabs.com>
References: <20040608123656.GG14247@lbsd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004, Nigel Kukard wrote:

> I get the following error trying to access a mounted smb filesystem.
> 100% reproducable on my sytem.
>
> Please let me know if you require anymore info.

A known issue, there is also a bugzilla entry at the following URL with a
temporary fix (needs a bit of work to satisfy the maintainer, which i'll
get round to one of these evenings).

http://bugme.osdl.org/show_bug.cgi?id=1671

Feel free to add yourself to the Cc list.
