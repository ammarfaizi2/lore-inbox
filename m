Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbTIVFZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 01:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbTIVFZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 01:25:50 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:55823
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262980AbTIVFZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 01:25:49 -0400
Subject: Re: [ANNOUNCE]  slab information utility
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Chris Rivera <cmrivera@ufl.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20030922051754.GF4306@holomorphy.com>
References: <1064199786.1199.29.camel@boobies.awol.org>
	 <20030922051754.GF4306@holomorphy.com>
Content-Type: text/plain
Message-Id: <1064208319.8888.248.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 01:25:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-22 at 01:17, William Lee Irwin III wrote:

> I wrote something I called this earlier on; I'll withdraw any claim of
> mine on the name since this utility is clearly superior to it and I'd
> rather endorse it than my own creation.

Sweet.  Hope you like it.  I think its very valuable during all sorts of
kernel debugging (or even simple administrating), because everything is
tied into the slab layer but /proc/slabinfo, while useful information,
is impossible to grok.

This is actually inspired (although not really based on) Martin Bligh's
vmtop perl script.  I just checked in a little "thanks" to him into the
man page ;-)

	Robert Love


