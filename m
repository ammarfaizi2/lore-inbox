Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUGRUwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUGRUwL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 16:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUGRUwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 16:52:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25067 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264519AbUGRUwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 16:52:08 -0400
Date: Sun, 18 Jul 2004 16:51:24 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@devserv.devel.redhat.com
To: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security/selinux/hooks.c:1898: error: `PER_CLEAR_ON_SETID'
 undeclared
In-Reply-To: <200407181425.43629.pluto@pld-linux.org>
Message-ID: <Pine.LNX.4.58.0407181647590.7127@devserv.devel.redhat.com>
References: <200407181425.43629.pluto@pld-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jul 2004, [iso-8859-2] Pawe³ Sikora wrote:

>   CC      security/selinux/hooks.o
> security/selinux/hooks.c: In function `selinux_bprm_apply_creds':
> security/selinux/hooks.c:1898: error: `PER_CLEAR_ON_SETID' undeclared

I can't find this symbol anywhere in the kernel.  Is this stock 
2.6.8-rc2?


- James
-- 
James Morris
<jmorris@redhat.com>

