Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWGGJmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWGGJmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWGGJmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:42:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7331 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932083AbWGGJmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:42:02 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1152193217.2987.182.camel@pmac.infradead.org> 
References: <1152193217.2987.182.camel@pmac.infradead.org>  <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124719.7098.73359.stgit@warthog.cambridge.redhat.com> 
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       bernds_cb1@t-online.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] FDPIC: Fix FDPIC compile errors [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 07 Jul 2006 10:41:44 +0100
Message-ID: <20138.1152265304@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> Isn't this just working around a compiler problem -- a spurious warning?
> It certainly shouldn't be a 'compile error',

It's fixed as for binfmt_elf.c.  You can unfix binfmt_elf.c if you wish.

David
