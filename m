Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758060AbWK0LZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758060AbWK0LZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 06:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758056AbWK0LZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 06:25:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18412 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1758054AbWK0LZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 06:25:38 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061126040416.GH15364@stusta.de> 
References: <20061126040416.GH15364@stusta.de> 
To: Adrian Bunk <bunk@stusta.de>
Cc: dhowells@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill net/rxrpc/rxrpc_syms.c 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 27 Nov 2006 11:21:25 +0000
Message-ID: <30354.1164626485@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> This patch moves the EXPORT_SYMBOL's from net/rxrpc/rxrpc_syms.c to the 
> files with the actual functions.

You can if you like.  Can you slap a blank line before each EXPORT_SYMBOL()
though please?

David
