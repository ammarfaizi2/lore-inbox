Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWHYVmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWHYVmt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWHYVmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:42:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751506AbWHYVms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:42:48 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060824182044.GE17658@us.ibm.com> 
References: <20060824182044.GE17658@us.ibm.com>  <20060824181722.GA17658@us.ibm.com> 
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 22:42:45 +0100
Message-ID: <8024.1156542165@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> filldir()'s inode number is now type u64 instead of ino_t.

Acked-By: David Howells <dhowells@redhat.com>
