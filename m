Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVJCIM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVJCIM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 04:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVJCIM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 04:12:26 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:13861 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932191AbVJCIMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 04:12:25 -0400
Subject: Re: [PATCH] Document patch subject line better
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Paul Jackson <pj@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>,
       Coywolf Qi Hunt <coywolf@gmail.com>, Greg KH <greg@kroah.com>
In-Reply-To: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 10:12:06 +0200
Message-Id: <1128327126.14695.40.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 00:29 -0700, Paul Jackson wrote:

> +The "summary phrase" in the email's Subject should concisely
> +describe the patch which that email contains.  The "summary
> +phrase" should not be a filename.  Do not use the same "summary
> +phrase" for every patch in a whole patch series.

On that last sentence, does quilt support having different subjects for
different patches?


-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

