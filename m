Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936519AbWLAPZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936519AbWLAPZt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936522AbWLAPZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:25:49 -0500
Received: from pat.uio.no ([129.240.10.15]:47276 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S936519AbWLAPZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:25:49 -0500
Subject: Re: 2.6.19: nfs-related kernel NULL pointer dereference
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Sven Geggus <sven-im-usenet@gegg.us>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ekpeot$caj$1@ultimate100.geggus.net>
References: <ekpeot$caj$1@ultimate100.geggus.net>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 10:23:51 -0500
Message-Id: <1164986631.5761.93.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.219, required 12,
	autolearn=disabled, AWL 1.64, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 14:38 +0000, Sven Geggus wrote:
> Hello,
> 
> while trying to boot Kernel 2.6.19 (vanilla+unionfs) I get the following
> NULL pointer dereferences:

Are you able to reproduce this without unionfs?

Trond

