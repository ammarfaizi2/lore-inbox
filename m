Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031262AbWLEUR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031262AbWLEUR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031263AbWLEUR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:17:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52299 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031262AbWLEUR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:17:26 -0500
Date: Tue, 5 Dec 2006 12:16:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, jdike@karaya.com,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: GIT pull on work_struct reduction tree
Message-Id: <20061205121632.65572efb.akpm@osdl.org>
In-Reply-To: <24327.1165348363@redhat.com>
References: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>
	<24327.1165348363@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2006 19:52:43 +0000
David Howells <dhowells@redhat.com> wrote:

> I've brought the work_struct reduction patches up to date.  They're in a GIT
> tree for you to pull when you're ready.

Given that I (and probably many others) now have a pile of build errors to
fix, it would be nice to have a short-but-full description of what one must
do to fix those up, please.
