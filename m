Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbTIVFVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 01:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbTIVFVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 01:21:51 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:52239
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262968AbTIVFVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 01:21:49 -0400
Subject: Re: [ANNOUNCE]  slab information utility
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@osdl.org>
Cc: herbert@13thfloor.at, cmrivera@ufl.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20030921221849.7c4191c5.akpm@osdl.org>
References: <1064199786.1199.29.camel@boobies.awol.org>
	 <20030922042308.GA8691@DUK2.13thfloor.at>
	 <1064205590.8888.207.camel@localhost>
	 <20030921221849.7c4191c5.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1064208104.8888.243.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 01:21:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-22 at 01:18, Andrew Morton wrote:

> Verboten.  I'll fix that up.  I'll also slip a BUG_ON(strchr(name, ' '));
> into kmem_cache_create()...

Much thanks, Andrew.

	Robert Love


