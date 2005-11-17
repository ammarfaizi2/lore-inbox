Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVKQWPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVKQWPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVKQWO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:14:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932289AbVKQWO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:14:59 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200511172130.jAHLUCP0010033@turing-police.cc.vt.edu> 
References: <200511172130.jAHLUCP0010033@turing-police.cc.vt.edu>  <20051117111807.6d4b0535.akpm@osdl.org> 
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 17 Nov 2005 22:14:46 +0000
Message-ID: <8752.1132265686@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Valdis.Kletnieks@vt.edu wrote:

> Why does keyctl.c declare it as 'asmlinkage'?

Because it's wrong.

Acked-By: David Howells <dhowells@redhat.com>

