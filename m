Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVCWKnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVCWKnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 05:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVCWKnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 05:43:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37281 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261534AbVCWKm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 05:42:29 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.62.0503222359450.2683@dragon.hyggekrogen.localhost> 
References: <Pine.LNX.4.62.0503222359450.2683@dragon.hyggekrogen.localhost> 
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Eric Youngdale <ericy@cais.com>
Subject: Re: [PATCH] remove NULL checks before kfree in binfmt_elf_fdpic.c and binfmt_elf.c 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Mar 2005 10:42:24 +0000
Message-ID: <26987.1111574544@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jesper Juhl <juhl-lkml@dif.dk> wrote:

> remove redundant NULL checks before kfree() in fs/binfmt_elf_fdpic.c and 
> fs/binfmt_elf.c

The FDPIC bit looks okay.

Acked-By: David Howells <dhowells@redhat.com>
