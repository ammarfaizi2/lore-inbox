Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422652AbWJRSmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbWJRSmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWJRSmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:42:44 -0400
Received: from [198.99.130.12] ([198.99.130.12]:35735 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161271AbWJRSmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:42:43 -0400
Date: Wed, 18 Oct 2006 14:41:22 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 00/10] Various UML patches for 2.6.19
Message-ID: <20061018184122.GC6566@ccure.user-mode-linux.org>
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 11:19:43PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Some other tested and little UML fixes for 2.6.19 (not all ones are oneliner,
> but those ones are tested).

These are acked, except as noted.  I don't like uml-fix-prototypes.patch
or uml-make-execvp-safe-for-our-usage.patch - don't kick them out of
-mm, but don't send them to Linus as yet.

				Jeff
