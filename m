Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWHJKRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWHJKRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 06:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbWHJKR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 06:17:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65172 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161140AbWHJKR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 06:17:29 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200608092356.13246.rjw@sisk.pl> 
References: <200608092356.13246.rjw@sisk.pl>  <32278.1155057836@warthog.cambridge.redhat.com> <20060804192540.17098.39244.stgit@warthog.cambridge.redhat.com> <912.1155131006@warthog.cambridge.redhat.com> 
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ReiserFS: Make sure all dentries refs are released before calling kill_block_super() [try #2] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 10 Aug 2006 11:16:55 +0100
Message-ID: <25566.1155205015@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki <rjw@sisk.pl> wrote:

> This one works on my box just fine.

Excellent, thanks.

David
