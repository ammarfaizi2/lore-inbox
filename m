Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUBJQ7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 11:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUBJQ4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 11:56:45 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:50406 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S266005AbUBJQx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 11:53:57 -0500
To: David =?iso-8859-1?Q?Posp=ED=B9il?= <foton2@post.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security patch for 2.6.2
In-Reply-To: <1nIMg-5FD-9@gated-at.bofh.it>
References: <1nIMg-5FD-9@gated-at.bofh.it>
Date: Tue, 10 Feb 2004 17:54:48 +0100
Message-Id: <E1Aqb9s-00002Y-JV@localhost>
From: der.eremit@email.de
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 17:20:08 +0100, you wrote in linux.kernel:

> Where can I find security patch for 2.6.2 ?
> Problem : look at this site : http://www.securityfocus.com/archive/1/353217
> It is remote root exploit :-(

Read the full thread, it is a userspace problem caused by smbmnt
being setuid root in some distributions.

-- 
Ciao,
Pascal
