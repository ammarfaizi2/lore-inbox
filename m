Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVGLQ7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVGLQ7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVGLQ7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:59:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14481 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261572AbVGLQ7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:59:35 -0400
Subject: Re: [PATCH] kjournald() missing JFS_UNMOUNT check
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050711211926.GC14505@ca-server1.us.oracle.com>
References: <20050711211926.GC14505@ca-server1.us.oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121187560.1923.53.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 12 Jul 2005 17:59:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-07-11 at 22:19, Mark Fasheh wrote:

> 	Can we please merge this patch? I sent it to ext2-devel for comments
> last week and haven't hear anything back. It seems trivially correct and is
> testing fine - famous last words, I know :)

ACK --- looks fine to me.

--Stephen

