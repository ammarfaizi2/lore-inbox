Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVJGXjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVJGXjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 19:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVJGXjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 19:39:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24496 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964877AbVJGXjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 19:39:06 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051007233547.GH5856@shell0.pdx.osdl.net> 
References: <20051007233547.GH5856@shell0.pdx.osdl.net>  <20051007220426.GC5856@shell0.pdx.osdl.net> <19008.1128699684@warthog.cambridge.redhat.com> <11615.1128694058@warthog.cambridge.redhat.com> <26883.1128700665@warthog.cambridge.redhat.com> <12605.1128728040@warthog.cambridge.redhat.com> 
To: Chris Wright <chrisw@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [Keyrings] [PATCH] Keys: Add LSM hooks for key management [try #2] 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Sat, 08 Oct 2005 00:38:54 +0100
Message-ID: <12790.1128728334@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:

> I thought that too at first, which is why I flagged it at first.  But I
> think it's actually not a real problem, because isn't that !CONFIG_KEYS?
> So, I think it's just cosmetic.

It is a problem; at least I found it to be one. And no it isn't !CONFIG_KEYS.

David
