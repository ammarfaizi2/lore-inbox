Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935867AbWK1LUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935867AbWK1LUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 06:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935866AbWK1LT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 06:19:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9699 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935863AbWK1LT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 06:19:58 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061128012830.GS15364@stusta.de> 
References: <20061128012830.GS15364@stusta.de>  <20061126040416.GH15364@stusta.de> <30354.1164626485@redhat.com> 
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill net/rxrpc/rxrpc_syms.c 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 28 Nov 2006 11:18:54 +0000
Message-ID: <13550.1164712734@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> > > This patch moves the EXPORT_SYMBOL's from net/rxrpc/rxrpc_syms.c to the 
> > > files with the actual functions.
> > 
> > You can if you like.  Can you slap a blank line before each EXPORT_SYMBOL()
> > though please?
> 
> Updated patch below.

Acked-By: David Howells <dhowells@redhat.com>
