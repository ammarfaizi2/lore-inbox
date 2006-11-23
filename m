Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933889AbWKWUEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933889AbWKWUEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933895AbWKWUEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:04:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6874 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933889AbWKWUEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:04:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0611230920230.27596@woody.osdl.org> 
References: <Pine.LNX.4.64.0611230920230.27596@woody.osdl.org>  <20061122132008.2691bd9d.akpm@osdl.org> <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com> <10937.1164282273@redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] WorkStruct: Shrink work_struct by two thirds 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 23 Nov 2006 20:01:11 +0000
Message-ID: <20447.1164312071@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> I obviously didn't see how nasty the conflicts were, and I would want it 
> to be not too painful for Andrew. So I could either take it early after 
> 2.6.19 _or_ after Andrew has merged the bulk of his stuff, depending on 
> which way is easier.

Perhaps if Andrew gives me an estimate of what patches he's going to commit
this time around, I can use those as a base for my patch.

David
