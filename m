Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVCFXJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVCFXJk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVCFXEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:04:53 -0500
Received: from [81.2.110.250] ([81.2.110.250]:62949 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261610AbVCFXBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 18:01:04 -0500
Subject: Re: 2.6.10-ac10 oops in journal_commit_transaction
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brice Figureau <brice+lklm@daysofwonder.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1109933468.4728.12.camel@localhost.localdomain>
References: <1109857541.29075.25.camel@localhost.localdomain>
	 <20050303153754.7a5deecd.akpm@osdl.org>
	 <1109933468.4728.12.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110149948.3072.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Mar 2005 22:59:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI Stephen Tweedie has now posted a patch for 2.6.x that ought to fix
this one.

Alan

