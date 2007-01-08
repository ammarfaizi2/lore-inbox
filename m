Return-Path: <linux-kernel-owner+w=401wt.eu-S932129AbXAHVeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbXAHVeF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbXAHVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:34:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45173 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbXAHVeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:34:02 -0500
Date: Mon, 8 Jan 2007 13:29:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 05/24] Unionfs: Copyup Functionality
Message-Id: <20070108132947.6a8f9cf4.akpm@osdl.org>
In-Reply-To: <11682295971184-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	<11682295971184-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Jan 2007 23:12:57 -0500
"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:

> From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> 
> This patch contains the functions used to perform copyup operations in unionfs.

What is a copyup operation and why does it exist?

It seems to be copying the entire contents of certain files.  That's not a
thing I'd have expected to see in a union filesystem.  Explain it all,
please?  (Somewhere where the info will be retained for posterity - a
random email is good, but not sufficient...)
