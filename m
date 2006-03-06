Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWCFOqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWCFOqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 09:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWCFOqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 09:46:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52715 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751193AbWCFOqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 09:46:05 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060304121439.GP9295@stusta.de> 
References: <20060304121439.GP9295@stusta.de>  <20060303045651.1f3b55ec.akpm@osdl.org> 
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] kernel/futex.c: make futexfs_get_sb() static again 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Mon, 06 Mar 2006 14:44:36 +0000
Message-ID: <17754.1141656276@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> futexfs_get_sb() became global for no good reason.

Oops.

Acked-By: David Howells <dhowells@redhat.com>
