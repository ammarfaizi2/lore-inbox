Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268161AbUIFPvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268161AbUIFPvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUIFPvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:51:52 -0400
Received: from mx02.qsc.de ([213.148.130.14]:19601 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S268161AbUIFPvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:51:51 -0400
Date: Mon, 06 Sep 2004 17:51:57 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <413C879D.nail51W11794T@pluto.uni-freiburg.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de>
 <20040906133523.GC25429@wohnheim.fh-wedel.de>
 <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de>
 <200409061646.41772.oliver@neukum.org>
In-Reply-To: <200409061646.41772.oliver@neukum.org>
User-Agent: nail 11.6pre 9/6/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <oliver@neukum.org> wrote:

> Am Montag, 6. September 2004 16:32 schrieb Gunnar Ritter:
> > Then I don't see the point in having a copyfile system call. In
>
> Potentially tremendous speedups in networked filesystems.

Which are even particularly susceptible to operations the user
might want to interrupt.

	Gunnar
