Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUFULxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUFULxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 07:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUFULxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 07:53:52 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:11445 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S266200AbUFULxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 07:53:51 -0400
Subject: Re: 2.6.7-bk way too fast
From: Marcel Holtmann <marcel@holtmann.org>
To: lkml@lpbproduction.scom
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200406202049.51853.lkml@lpbproductions.com>
References: <40D64DF7.5040601@pobox.com> <40D657B7.8040807@pobox.com>
	 <200406202049.51853.lkml@lpbproductions.com>
Content-Type: text/plain
Message-Id: <1087818808.4328.4.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 21 Jun 2004 13:53:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I believe it was already narrowed down by Hans-Frieder Vogt, see  
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108774225111967&w=2

this one fixes it for me, too. I had to replaces x86_64 with i386, but
actually this is obvious.

Regards

Marcel


