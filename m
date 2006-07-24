Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWGXOZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWGXOZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 10:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWGXOZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 10:25:19 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:64464 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932174AbWGXOZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 10:25:19 -0400
Subject: Re: [PATCH] Add maintainer for memory management
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org
In-Reply-To: <1153749795.23798.19.camel@lappy>
References: <1153713707.4002.43.camel@localhost.localdomain>
	 <1153749795.23798.19.camel@lappy>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 10:25:08 -0400
Message-Id: <1153751108.4002.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-24 at 16:03 +0200, Peter Zijlstra wrote:
> Hi Steven,
> 
> The way I understand the maintainership of the memory management code is
> as follows: there is explicitly no maintainer listed. This code is so
> sensitive and has interactions with so many other sub-systems that it
> would not be doable to look at it from all possible angles by only one
> person.
> 
> As it stands its more a group of people headed by Linus, Andrew and
> Hugh.
> 

Thanks Peter for the explanation.

So, I'll send another patch to just add the linux-mm mailing list, since
that should have no qualms about it.

Thanks,

-- Steve 

