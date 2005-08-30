Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVH3Key@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVH3Key (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 06:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVH3Key
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 06:34:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20383 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751345AbVH3Key (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 06:34:54 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200508291735.21880.jesper.juhl@gmail.com> 
References: <200508291735.21880.jesper.juhl@gmail.com> 
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove EXPORT_SYMBOL(strtok) from frv_ksyms.c 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Tue, 30 Aug 2005 11:34:33 +0100
Message-ID: <31636.1125398073@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:

> Remove export of strtok().
> strtok() has not been available in the kernel since 2002. 

Looks okay to me.

David
